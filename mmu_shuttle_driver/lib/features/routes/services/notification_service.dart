import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  Future<void> requestNotificationPermission() async {
    if (!Platform.isAndroid) return;

    bool isGranted = false;

    while (!isGranted) {
      var status = await Permission.notification.status;

      if (status.isGranted) {
        isGranted = true;
        break;
      }

      if (status.isDenied) {
        status = await Permission.notification.request();
      }

      if (status.isPermanentlyDenied) {
        print("Permission blocked by OS. Redirecting to app settings...");

        await openAppSettings();

        await Future.delayed(const Duration(seconds: 3));
      }
    }

    print("Notification permission successfully granted!");
  }
}
