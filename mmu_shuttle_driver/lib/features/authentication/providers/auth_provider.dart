import 'package:flutter/material.dart';
import 'package:mmu_shuttle_driver/features/authentication/models/driver_model.dart';
import 'package:mmu_shuttle_driver/features/authentication/models/login_request_model.dart';
import 'package:mmu_shuttle_driver/features/authentication/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();

  DriverModel? _currentDriver;
  bool _isLoading = true;
  String? _errorMessage;

  DriverModel? get currentDriver => _currentDriver;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> signIn(String email, String password) async {
    LoginRequestModel loginRequestModel = LoginRequestModel(
      email: email,
      password: password,
    );
    await _authService.signIn(loginRequestModel);
    return;
  }

  Future<void> getDriverProfile() async {
    try {
      _setLoadingState(true);
      _currentDriver = await _authService.getDriverProfile();
      _setLoadingState(false);
    } catch (e) {
      _setLoadingState(false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _currentDriver = null;
  }

  void _setLoadingState(bool loading, {String? error}) {
    _isLoading = loading;
    _errorMessage = error;
    notifyListeners();
  }

  void clearData() {
    _currentDriver = null;
    _isLoading = true;
    _errorMessage = null;
  }
}
