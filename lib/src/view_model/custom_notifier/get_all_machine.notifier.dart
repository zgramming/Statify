import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';

final getAllMachineFutureProvider = AutoDisposeFutureProvider((ref) async {
  final notifier = ref.read(machineNotifier.notifier);
  final result = await notifier.getAll();
  return result;
});
