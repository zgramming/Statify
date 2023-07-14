import 'package:flutter/services.dart';
import '../model/model/incoming_call_model.dart';

class EventChannelUtils {
  static const _callReceiverEventChannel =
      EventChannel('CALL_RECEIVER_EVENT_CHANNEL');

  static Stream<IncomingCallModel> listenIncomingCall() {
    final result =
        _callReceiverEventChannel.receiveBroadcastStream().map((event) {
      return IncomingCallModel.fromMap(Map.from(event));
    });

    return result;
  }
}
