import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';

final getAllMachineFutureProvider = FutureProvider((ref) async {
  final notifier = ref.watch(machineNotifier.notifier);
  final result = await notifier.getAll();
  return result;
});
