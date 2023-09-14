import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/user/user_model.dart';
import '../../model/model/phone_number_setting/phone_number_setting_model.dart';
import '../../utils/constant.dart';
import '../../utils/flutter_secure_storage.dart';

class InitializeApplicationModel extends Equatable {
  final UserModel? user;
  final PhoneNumberSettingModel? phoneNumberSetting;
  final bool isAlreadyIntroduction;

  const InitializeApplicationModel({
    this.user,
    this.phoneNumberSetting,
    required this.isAlreadyIntroduction,
  });

  @override
  List<Object?> get props => [user, phoneNumberSetting, isAlreadyIntroduction];

  @override
  bool get stringify => true;
}

final initializeApplicationNotifier = AutoDisposeFutureProvider((ref) async {
  final appConfig = ref.watch(applicationConfigNotifier.notifier);
  final phoneNumberSetting = ref.watch(phoneNumberSettingNotifier.notifier);

  // Load phone number setting
  final phoneSetting = (await phoneNumberSetting.getFirstPhoneNumberSetting())
      .onGetFirst
      .valueOrNull;

  final user = await FlutterSecureStorageUtils.getUserAuth();
  final introduction =
      (await appConfig.getByKey(kIntroductionKey)).onGetByKey.valueOrNull;
  final isAlreadyIntroduction = introduction?.value == 'true';

  if (user != null) {
    ref.read(userNotifier.notifier).setUser(user);
  }

  return InitializeApplicationModel(
    isAlreadyIntroduction: isAlreadyIntroduction,
    user: user,
    phoneNumberSetting: phoneSetting,
  );
});
