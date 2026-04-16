import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mmu_shuttle_driver/core/authentication/token_manager.dart';
import 'package:mmu_shuttle_driver/core/constants.dart';
import 'package:mmu_shuttle_driver/core/network/api.dart';
import 'package:mmu_shuttle_driver/features/authentication/models/driver_model.dart';
import 'package:mmu_shuttle_driver/features/authentication/models/login_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> signIn(LoginRequestModel loginRequestModel) async {
    try {
      final response = await dio.post(
        "/auth/driver/login",
        data: loginRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        String token = response.data;
        TokenManager.updateToken(token);
        await storage.write(key: CACHED_ACCESS_TOKEN_KEY, value: token);
        await storage.write(key: CACHED_EMAIL, value: loginRequestModel.email);
        await storage.write(
          key: CACHED_PASSWORD,
          value: loginRequestModel.password,
        );
      } else {
        throw Exception(DEFAULT_ERROR_MESSAGE);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<void> signOut() async {
    await storage.delete(key: CACHED_ACCESS_TOKEN_KEY);
    await storage.delete(key: CACHED_EMAIL);
    await storage.delete(key: CACHED_PASSWORD);
    TokenManager.updateToken(null);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('active_route_id');
  }

  Future<DriverModel> getDriverProfile() async {
    try {
      final response = await dio.get("/auth/driver/profile");
      if (response.statusCode == 200) {
        return DriverModel.fromJson(response.data);
      } else {
        throw Exception(DEFAULT_ERROR_MESSAGE);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<void> loadToken() async {
    final accessToken = await storage.read(key: CACHED_ACCESS_TOKEN_KEY);

    if (accessToken != null) {
      TokenManager.updateToken(accessToken);
    }
  }

  Future<LoginRequestModel> loadCredentialsFromStorage() async {
    final email = await storage.read(key: CACHED_EMAIL);
    final password = await storage.read(key: CACHED_PASSWORD);
    return LoginRequestModel(email: email ?? "", password: password ?? "");
  }
}
