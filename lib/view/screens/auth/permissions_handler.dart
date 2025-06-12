import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  /// Request location permission
  static Future<bool> requestLocation([BuildContext? context]) async {
    final status = await Permission.locationWhenInUse.request();

    if (status.isPermanentlyDenied) {
      if (context != null) {
        await _showSettingsDialog(
          context,
          "Location Access Needed",
          "Sevaki needs location to show nearby stores and delivery tracking",
          isCritical: true,
        );
      }
      return false;
    }

    return status.isGranted;
  }

  /// Request notification permission
  static Future<bool> requestNotifications([BuildContext? context]) async {
    if (Platform.isAndroid) {
      // Android 13+ requires runtime permission
      final status = await Permission.notification.request();
      return status.isGranted;
    }

    // iOS handling
    final status = await Permission.notification.request();
    if (status.isPermanentlyDenied && context != null) {
      await _showSettingsDialog(
        context,
        "Notifications Disabled",
        "Please enable notifications to receive order updates",
        isCritical: false,
      );
    }
    return status.isGranted;
  }

  /// Request SMS permission (Android only)
  static Future<bool> requestSmsPermission([BuildContext? context]) async {
    if (!Platform.isAndroid) return true;

    final status = await Permission.sms.request();
    if (status.isPermanentlyDenied && context != null) {
      await _showSettingsDialog(
        context,
        "SMS Permission Required",
        "Required for automatic OTP verification",
        isCritical: false,
      );
    }
    return status.isGranted;
  }

  /// Show settings dialog
  static Future<void> _showSettingsDialog(
      BuildContext context,
      String title,
      String message, {
        required bool isCritical,
      }) async {
    await showDialog(
      context: context,
      barrierDismissible: !isCritical,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (!isCritical)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Later"),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text("Settings"),
          ),
        ],
      ),
    );
  }
}