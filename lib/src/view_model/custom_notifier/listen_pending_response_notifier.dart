import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../custom_provider/custom_provider.dart';

final listenPendingResponseNotifier =
    AutoDisposeStreamProviderFamily<String?, String>((ref, machineId) {
  final machine = ref.watch(getMachineByIdProvider(machineId));
  if (machine == null) {
    return throw Exception('Machine is not found when listen pending response');
  }

  final activeSurveyId = machine.activeSurveyId;

  if (activeSurveyId == null) {
    return throw Exception(
      'Active survey id is null when listen pending response',
    );
  }

  final simSlot = ref.watch(userChooseSIMMachineProvider(machineId));

  final stream = ref
      .watch(surveyNotifier(machineId).notifier)
      .listenPendingResponse(simSlot: simSlot, surveyId: activeSurveyId);

  return stream;
});
