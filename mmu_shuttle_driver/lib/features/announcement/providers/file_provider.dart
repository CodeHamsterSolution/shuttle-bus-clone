import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mmu_shuttle_driver/features/announcement/services/file_service.dart';

class FileProvider extends ChangeNotifier {
  // variables
  File? _file;
  bool _isLoading = true;
  String? _errorMesssage;

  final _fileService = FileService();

  // getters
  File? get file => _file;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMesssage;

  // methods
  Future<void> getFile({required String fileName}) async {
    _setLoadingState(true);
    try {
      final bytes = await _fileService.fetchFile(fileName);
      _file = await _fileService.saveFile(fileName, bytes);
      _setLoadingState(false);
    } catch (e) {
      _setLoadingState(false, error: e.toString());
    }
  }

  void _setLoadingState(bool loading, {String? error}) {
    _isLoading = loading;
    _errorMesssage = error;
    notifyListeners();
  }

  void clearData() {
    _file = null;
    _isLoading = true;
    _errorMesssage = null;
  }
}
