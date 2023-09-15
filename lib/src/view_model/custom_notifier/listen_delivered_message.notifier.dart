import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../utils/event_channel.dart';

final listenDeliveredMessageNotifier = AutoDisposeStreamProvider((ref) async* {
  // Initial Stream to trigger Delivered Message
  yield* Stream.value(null);

  final channel = EventChannelUtils();
  final stream = channel.listenOnDeliveredSMS();

  final logNotifier = ref.watch(logListenPendingResponseNotifier.notifier);
  final srvNotifier = ref.watch(surveyResponseNotifier.notifier);

  stream.listen((event) async {
    if (event.surveyResponseId.isEmpty) return;
    logNotifier.addLog(event.message);

    log("Delivered Message: $event");

    if (event.status) {
      final result = await srvNotifier.sent(event.surveyResponseId);
      result.onSent.whenOrNull(
        data: (data) =>
            logNotifier.addLog("Survey Response Sent With Id: ${data?.id}"),
        error: (error, stackTrace) => logNotifier.addLog(error.toString()),
      );
    } else {
      final result = await srvNotifier.fail(event.surveyResponseId);
      result.onFail.whenOrNull(
        data: (data) =>
            logNotifier.addLog("Survey Response Fail With Id: ${data?.id}"),
        error: (error, stackTrace) => logNotifier.addLog(error.toString()),
      );
    }
  });
  yield stream;
});
