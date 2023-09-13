import 'package:flutter/services.dart';

import '../model/model/incoming_sms/incoming_sms.model.dart';

class EventChannelUtils {
  // static const _callReceiverEventChannel =
  //     EventChannel('CALL_RECEIVER_EVENT_CHANNEL');
  final channel = const EventChannel('STATIFY_EVENT_CHANNEL');

  Stream<IncomingSMSModel> listenIncomingSMS() {
    final result = channel.receiveBroadcastStream().map((event) {
      return IncomingSMSModel.fromMap(Map.from(event));
    });

    return result;
  }
// static Stream<IncomingCallModel> listenIncomingCall() {
//   final result =
//       _callReceiverEventChannel.receiveBroadcastStream().map((event) {
//     return IncomingCallModel.fromMap(Map.from(event));
//   });

//   return result;
// }
}
