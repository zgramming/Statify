import 'package:flutter/services.dart';

import '../model/model/incoming_sms/incoming_sms.model.dart';
import '../model/model/listen_onsent_sms.model.dart';

class EventChannelUtils {
  // static const _callReceiverEventChannel =
  //     EventChannel('CALL_RECEIVER_EVENT_CHANNEL');
  final channelIncomignSMS =
      const EventChannel('STATIFY_EVENT_CHANNEL_INCOMING_SMS');
  final channelSentSMS = const EventChannel('STATIFY_EVENT_CHANNEL_SENT_SMS');
  final channelDeliveredSMS =
      const EventChannel('STATIFY_EVENT_CHANNEL_DELIVERED_SMS');

  Stream<IncomingSMSModel> listenIncomingSMS() {
    final result = channelIncomignSMS
        .receiveBroadcastStream()
        .map((event) => IncomingSMSModel.fromMap(Map.from(event)));

    return result;
  }

  Stream<ListenOnsentSMSModel> listenOnSentSMS() {
    final result = channelSentSMS.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return ListenOnsentSMSModel.fromMap(map);
    });

    return result;
  }

  Stream<dynamic> listenOnDeliveredSMS() {
    final result = channelDeliveredSMS.receiveBroadcastStream().map((event) {
      return event;
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
