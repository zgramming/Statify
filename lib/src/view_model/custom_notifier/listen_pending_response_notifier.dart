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
    log("listenPendingResponseNotifier: $event");
  });

  return stream;
});
