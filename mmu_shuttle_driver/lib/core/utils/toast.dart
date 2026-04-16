import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showErrorToast(BuildContext context, String message) {
  if (context.mounted) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      applyBlurEffect: true,
    );
  }
}

void showSuccessToast(BuildContext context, String message) {
  if (context.mounted) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      applyBlurEffect: true,
    );
  }
}
