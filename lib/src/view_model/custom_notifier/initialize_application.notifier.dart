import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/initialize_application.model.dart';
import '../../utils/constant.dart';
import '../../utils/flutter_secure_storage.dart';

final initializeApplicationNotifier = AutoDisposeFutureProvider((ref) async {
  final appConfig = ref.watch(applicationConfigNotifier.notifier);
  final logo = ref.watch(logoNotifier.notifier);

  final user = await FlutterSecureStorageUtils.getUserAuth();
  final introduction =
      (await appConfig.getByKey(kIntroductionKey)).onGetByKey.valueOrNull;
  final isAlreadyIntroduction = introduction?.value == 'true';
  final resultLogo = (await logo.getFirstLogo(
    invalidate: false,
  ))
      .onGetFirstLogo
      .valueOrNull;

  if (user != null) {
    ref.read(userNotifier.notifier).setUser(user);
  }

  return InitializeApplicationModel(
    isAlreadyIntroduction: isAlreadyIntroduction,
    user: user,
    logo: resultLogo,
  );
});
