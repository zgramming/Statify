import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';

final getAllMachineFutureProvider = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(machineNotifier.notifier);
  final result = await notifier.getAll();
  final stateGetAll = result.onGetAll;

  if (stateGetAll is AsyncError) {
    throw Exception(stateGetAll.error);
  }

  return result;
});
