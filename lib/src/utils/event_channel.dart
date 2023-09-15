import 'package:flutter/services.dart';

import '../model/model/incoming_call_model.dart';
import '../model/model/incoming_sms/incoming_sms.model.dart';
import '../model/model/listen_ondelivered_sms.model.dart';
import '../model/model/listen_onsent_sms.model.dart';

class EventChannelUtils {
  static const channelIncomingCall =
      EventChannel('STATIFY_EVENT_CHANNEL_INCOMING_CALL');
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

  Stream<ListenOnDeliveredSMSModel> listenOnDeliveredSMS() {
    final result = channelDeliveredSMS.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return ListenOnDeliveredSMSModel.fromMap(map);
    });

    return result;
  }

  static Stream<IncomingCallModel> listenIncomingCall() {
    final result = channelIncomingCall.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return IncomingCallModel.fromMap(map);
    });

    return result;
  }
}
