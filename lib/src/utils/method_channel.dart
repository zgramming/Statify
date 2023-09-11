import 'dart:developer';

import 'package:flutter/services.dart';

class MethodChannelUtils {
  final platform = const MethodChannel('STATIFY_METHOD_CHANNEL');

  Future<bool> sendSMS({
    required String phoneNumber,
    required String message,
    required int simSlot,
  }) async {
    try {
      final result = await platform.invokeMethod(
        'sendSMS',
        {
          'phoneNumber': phoneNumber,
          'message': message,
          'simSlot': simSlot,
        },
      );
      log("RESULT  SMS Flutter: $result");
      return result;
    } on PlatformException catch (e) {
      log("Error PlatformException Flutter: $e");
      return false;
    } catch (e) {
      log("Error Flutter: $e");
      return false;
    }
  }
}
