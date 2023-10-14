import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final checkPermissionNotifier = AutoDisposeFutureProvider((ref) async {
  final deviceInfoAndroid = await DeviceInfoPlugin().androidInfo;
  final androidSDKInt = deviceInfoAndroid.version.sdkInt;
  final isAndroid13 = androidSDKInt > 32;

  final phonePermission = await Permission.phone.request();

  if (phonePermission != PermissionStatus.granted) {
    throw "Permission phone not granted";
  }

  final smsPermission = await Permission.sms.request();

  if (smsPermission != PermissionStatus.granted) {
    throw "Permission sms not granted";
  }

  // If android 13 or above, request photos, videos permission
  // else request storage permission

  if (isAndroid13) {
    final photosPermission = await Permission.photos.request();

    if (photosPermission != PermissionStatus.granted) {
      throw "Permission photos not granted";
    }

    final videosPermission = await Permission.videos.request();

    if (videosPermission != PermissionStatus.granted) {
      throw "Permission videos not granted";
    }
  } else {
    final storagePermission = await Permission.storage.request();

    if (storagePermission != PermissionStatus.granted) {
      throw "Permission storage not granted";
    }
  }

  return true;
});
