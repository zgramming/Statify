import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/application_config/application_config_model.dart';

final getApplicationConfigByKeyFutureProvider =
    FutureProviderFamily<ApplicationConfigModel?, String>((ref, key) async {
  final future =
      await ref.watch(applicationConfigNotifier.notifier).getByKey(key);
  final result = future.onGetByKey.valueOrNull;
  return result;
});
