import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/machine/machine_model.dart';
import '../../model/model/survey/survey.model.dart';
import 'get_all_machine.notifier.dart';

final getAllSurveyByUserGroupByMachineFutureProvider =
    AutoDisposeFutureProvider<Map<MachineModel, List<SurveyModel>>>(
        (ref) async {
  final userId = ref.watch(userNotifier.select((value) => value.user))?.id;
  final surveysAsync =
      await ref.watch(userNotifier.notifier).getAllSurvey(userId!);

  final surveys = surveysAsync.onGetAllSurvey.valueOrNull ?? [];
  final surveyGroupByMachine = groupBy(surveys, (survey) => survey.machineId);

  final machineAsync = await ref.watch(getAllMachineFutureProvider.future);
  final machines = machineAsync.items;
  final mapping =
      surveyGroupByMachine.map<MachineModel, List<SurveyModel>>((key, value) {
    final machine = machines.firstWhere((element) => element.id == key);
    final values = value;
    return MapEntry(machine, values);
  });

  return mapping;
});
