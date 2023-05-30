import 'package:flutter/services.dart';

class EventChannelUtils {
  static const _callReceiverEventChannel =
      EventChannel('CALL_RECEIVER_EVENT_CHANNEL');

  static Stream listenIncomingCall() {
    final result = _callReceiverEventChannel.receiveBroadcastStream();
    return result;
  }
}
