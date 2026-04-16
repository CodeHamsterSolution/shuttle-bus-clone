import 'package:dio/dio.dart';
import 'package:mmu_shuttle_driver/core/constants.dart';
import 'package:mmu_shuttle_driver/core/network/api.dart';
import 'package:mmu_shuttle_driver/features/routes/models/route_model.dart';
import 'package:mmu_shuttle_driver/features/routes/models/live_ride_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteService {
  Future<List<RouteModel>> fetchRoutes() async {
    try {
      final response = await dio.get("/routes/mobile");
      if (response.statusCode == 200) {
        return response.data
            .map<RouteModel>((json) => RouteModel.fromJson(json))
            .toList();
      }
      throw Exception(DEFAULT_ERROR_MESSAGE);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<void> startRoute(LiveRideModel startRideModel) async {
    try {
      final response = await dio.post(
        "/routes/start",
        data: startRideModel.toJson(),
      );
      if (response.statusCode == 200) {
        try {
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt('active_route_id', startRideModel.routeId);
        } catch (e) {
          print(
            'Warning: Could not save route state locally. Phone storage might be full: $e',
          );
        }
      } else {
        throw Exception(DEFAULT_ERROR_MESSAGE);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<void> stopRoute(int routeId) async {
    try {
      final response = await dio.post(
        "/routes/end",
        queryParameters: {'routeId': routeId},
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('active_route_id');
      } else {
        throw Exception(DEFAULT_ERROR_MESSAGE);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<int?> getActiveRideIdFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('active_route_id');
  }

  Future<int?> getActiveRideIdFromServer() async {
    try {
      final response = await dio.get("/routes/driver/active");
      if (response.statusCode == 200) {
        final int? routeId = int.tryParse(response.data.toString());

        if (routeId != null) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt('active_route_id', routeId);
        }

        return routeId;
      }
      throw Exception(DEFAULT_ERROR_MESSAGE);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? DEFAULT_ERROR_MESSAGE);
    } catch (e) {
      throw Exception(DEFAULT_ERROR_MESSAGE);
    }
  }
}
