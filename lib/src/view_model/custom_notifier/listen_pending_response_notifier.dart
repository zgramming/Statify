import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../custom_provider/custom_provider.dart';

final listenPendingResponseNotifier =
    AutoDisposeStreamProviderFamily<String?, String>(
  (ref, machineId) {
    final machine = ref.watch(CustomProvider.getMachineByIdProvider(machineId));
    if (machine == null) {
      return throw Exception(
        'Machine is not found when listen pending response',
      );
    }

    final activeSurveyId = machine.activeSurveyId;

    if (activeSurveyId == null) {
      log("Machine ${machine.name} does not have active survey, please activate survey first to listen pending response");
      return Stream.value("");
      // return throw Exception(
      //   'Machine ${machine.name} does not have active survey, please activate survey first to listen pending response',
      // );
    }

    final simSlot = ref.watch(
      CustomProvider.userChooseSIMMachineProvider(machineId),
    );

    final stream = ref
        .watch(surveyNotifier(machineId).notifier)
        .listenPendingResponse(simSlot: simSlot, surveyId: activeSurveyId);

    return stream;
  },
);
