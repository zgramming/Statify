import 'dart:developer';

import 'package:flutter/services.dart';

import '../model/model/send_sms_model.dart';

class MethodChannelUtils {
  final platform = const MethodChannel('STATIFY_METHOD_CHANNEL');

  Future<bool> sendSMS(SendSMSModel model) async {
    try {
      final result = await platform.invokeMethod(
        'sendSMS',
        {
          'phoneNumber': model.phoneNumber,
          'message': model.message,
          'simSlot': model.simSlot,
          'surveyRespondenId': model.surveyRespondenId,
          'surveyRespondenResponseId': model.surveyRespondenResponseId,
        },
      );
      return result;
    } on PlatformException catch (e) {
      log("Error PlatformException Flutter: $e");
      return false;
    } catch (e) {
      log("Error Flutter: $e");
      return false;
    }
  }

  Future<bool> triggerIncomingMessage() async {
    try {
      final result =
          await platform.invokeMethod<bool>('triggerIncomingMessage');
      return result ?? false;
    } on PlatformException catch (e) {
      log("Error PlatformException Flutter: $e");
      return false;
    } catch (e) {
      log("Error Flutter: $e");
      return false;
    }
  }
}
