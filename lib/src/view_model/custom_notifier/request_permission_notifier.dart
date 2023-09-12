import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/flutter_local_notification.dart';

final checkPermissionNotifier = AutoDisposeFutureProvider((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final phonePermission = await Permission.phone.request();

  if (phonePermission != PermissionStatus.granted) {
    throw "Permission phone not granted";
  }

  final smsPermission = await Permission.sms.request();

  if (smsPermission != PermissionStatus.granted) {
    throw "Permission sms not granted";
  }

  final notificationPermission =
      await FlutterLocalNotificationUtils().requestPermissions();

  if (!notificationPermission) {
    throw "Permission notification not granted";
  }

  return true;
});
