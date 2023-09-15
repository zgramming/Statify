import 'package:flutter/services.dart';

import '../model/model/incoming_call_model.dart';
import '../model/model/incoming_sms/incoming_sms.model.dart';
import '../model/model/listen_ondelivered_sms.model.dart';
import '../model/model/listen_onsent_sms.model.dart';

class EventChannelUtils {
  final channelIncomingCall =
      const EventChannel('STATIFY_EVENT_CHANNEL_INCOMING_CALL');
  final channelIncomingSMS =
      const EventChannel('STATIFY_EVENT_CHANNEL_INCOMING_SMS');
  final channelSentSMS = const EventChannel('STATIFY_EVENT_CHANNEL_SENT_SMS');
  final channelDeliveredSMS =
      const EventChannel('STATIFY_EVENT_CHANNEL_DELIVERED_SMS');

  Stream<IncomingSMSModel?> listenIncomingSMS() {
    final result = channelIncomingSMS
        .receiveBroadcastStream()
        .map<IncomingSMSModel?>((event) {
      if (event == null) return null;
      return IncomingSMSModel.fromMap(Map.from(event));
    });

    return result;
  }

  Stream<ListenOnsentSMSModel> listenOnSentSMS() {
    final result = channelSentSMS.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return ListenOnsentSMSModel.fromMap(map);
    });

    return result;
  }

  Stream<ListenOnDeliveredSMSModel> listenOnDeliveredSMS() {
    final result = channelDeliveredSMS.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return ListenOnDeliveredSMSModel.fromMap(map);
    });

    return result;
  }

  Stream<IncomingCallModel> listenIncomingCall() {
    final result = channelIncomingCall.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return IncomingCallModel.fromMap(map);
    });

    return result;
  }
}
