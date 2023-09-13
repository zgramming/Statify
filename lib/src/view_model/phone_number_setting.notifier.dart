import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/database/database.dart';
import '../model/model/phone_number_setting/phone_number_setting_model.dart';
import '../model/repository/phone_numer_setting.repository.dart';

class PhoneNumberSettingState extends Equatable {
  final AsyncValue<List<PhoneNumberSettingModel>> onGetAll;
  final AsyncValue<PhoneNumberSettingModel?> onGetFirst;
  final AsyncValue<bool?> onUpsert;

  const PhoneNumberSettingState({
    this.onGetAll = const AsyncValue.data([]),
    this.onUpsert = const AsyncValue.loading(),
    this.onGetFirst = const AsyncValue.loading(),
  });

  @override
  List<Object?> get props => [
        onGetAll,
        onUpsert,
        onGetFirst,
      ];

  @override
  bool get stringify => true;

  PhoneNumberSettingState copyWith({
    AsyncValue<List<PhoneNumberSettingModel>>? onGetAll,
    AsyncValue<bool?>? onUpsert,
    AsyncValue<PhoneNumberSettingModel?>? onGetFirst,
  }) {
    return PhoneNumberSettingState(
      onGetAll: onGetAll ?? this.onGetAll,
      onUpsert: onUpsert ?? this.onUpsert,
      onGetFirst: onGetFirst ?? this.onGetFirst,
    );
  }
}

class PhoneNumberSettingNotifier
    extends StateNotifier<PhoneNumberSettingState> {
  PhoneNumberSettingNotifier({
    required this.repository,
  }) : super(const PhoneNumberSettingState()) {
    getAllPhoneNumberSetting();
  }

  final PhoneNumberSettingRepository repository;

  Future<PhoneNumberSettingState> getAllPhoneNumberSetting() async {
    state = state.copyWith(onGetAll: const AsyncValue.loading());
    final result = await repository.getAllPhoneNumberSetting();

    final fold = result.fold(
      (failure) => state = state.copyWith(
        onGetAll: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onGetAll: AsyncValue.data(data)),
    );

    return fold;
  }

  Future<PhoneNumberSettingState> getFirstPhoneNumberSetting({
    bool invalidate = false,
  }) async {
    if (invalidate) {
      state = state.copyWith(onGetFirst: const AsyncValue.loading());
    }
    final result = await repository.getFirstPhoneNumberSetting();

    final fold = result.fold(
      (failure) => state = state.copyWith(
        onGetFirst: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onGetFirst: AsyncValue.data(data)),
    );

    return fold;
  }

  Future<PhoneNumberSettingState> upsertPhoneNumberSetting(
    PhoneNumberSettingTableCompanion phoneNumberSetting,
  ) async {
    state = state.copyWith(onUpsert: const AsyncValue.loading());
    final result =
        await repository.upsertPhoneNumberSetting(phoneNumberSetting);

    final fold = result.fold(
      (failure) => state = state.copyWith(
        onUpsert: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onUpsert: AsyncValue.data(data)),
    );

    return fold;
  }
}
