import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mmu_shuttle_driver/features/announcement/models/announcement_model.dart';
import 'package:mmu_shuttle_driver/features/announcement/models/create_announcement_model.dart';
import 'package:mmu_shuttle_driver/features/announcement/services/announcement_service.dart';

class AnnouncementProvider extends ChangeNotifier {
  // variables
  List<AnnouncementModel> _announcements = [];
  bool _isLoading = true;
  String? _errorMesssage;

  final _announcementService = AnnouncementService();

  // getters
  List<AnnouncementModel> get announcements => _announcements;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMesssage;

  // methods
  Future<void> createAnnouncement({
    required String title,
    required String description,
    required bool isPinned,
    required PlatformFile? uploadedFile,
  }) async {
    final announcement = CreateAnnouncementModel(
      title: title,
      description: description,
      isPinned: isPinned,
    );

    final formData = FormData.fromMap({
      'announcement': jsonEncode(announcement.toJson()),
      'file': uploadedFile?.bytes != null
          ? MultipartFile.fromBytes(
              uploadedFile!.bytes!,
              filename: uploadedFile.name,
            )
          : null,
    });

    final savedAnnouncement = await _announcementService.createNewAnnouncement(
      formData,
    );

    _announcements.add(savedAnnouncement);

    _applySort();

    notifyListeners();
  }

  void _applySort() {
    _announcements.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.createdAt.compareTo(a.createdAt);
    });
  }

  Future<void> togglePin(int id) async {
    await _announcementService.togglePin(id);
    final index = _announcements.indexWhere((a) => a.id == id);
    if (index != -1) {
      final current = _announcements[index];
      _announcements[index] = current.copyWith(isPinned: !current.isPinned);
      _applySort();
      notifyListeners();
    } else {
      throw Exception("Local State Corrupted");
    }
  }

  Future<void> fetchAnnouncements() async {
    _setLoadingState(true);
    try {
      _announcements = await _announcementService.fetchAnnouncements();
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
    _announcements = [];
    _isLoading = true;
    _errorMesssage = null;
  }
}
