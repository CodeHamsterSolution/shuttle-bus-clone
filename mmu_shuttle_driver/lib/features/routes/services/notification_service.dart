import 'dart:io';

import 'package:mmu_shuttle_driver/core/exceptions/NotificationException.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  Future<void> requestNotificationPermission() async {
    if (!Platform.isAndroid) return;
    var status = await Permission.notification.status;

    if (status.isGranted) {
      return;
    }

    if (status.isDenied) {
      status = await Permission.notification.request();

      if (status.isDenied) {
        throw NotificationException("Notification permissions are denied");
      }
    }

    if (status.isPermanentlyDenied) {
      throw NotificationException(
        'Notification permissions are permanently denied, we cannot request permissions.',
      );
    }
  }
}
