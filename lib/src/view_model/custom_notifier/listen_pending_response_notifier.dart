import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';

final listenPendingResponseNotifier =
    AutoDisposeStreamProviderFamily<String?, String>((ref, machineId) {
  // Listen self

  final stream = ref
      .watch(surveyResponseNotifier.notifier)
      .listenPendingResponse(machineId: machineId);

  stream.listen((event) {
    if (event != null) {
      log("listenPendingResponseNotifier: $event");
    } else {
      log("listenPendingResponseNotifier: null");
    }
  });

  return stream ?? Stream.value(null);
});
