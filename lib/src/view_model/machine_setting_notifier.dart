import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_machine_setting_create_update_model.dart';
import '../model/model/machine_setting/machine_setting_model.dart';
import '../model/model/machine_setting/machine_setting_update_response_model.dart';
import '../model/repository/machine_setting_repository.dart';

class MachineSettingState extends Equatable {
  final AsyncValue<List<MachineSettingModel>> onGetAll;
  final AsyncValue<MachineSettingModel?> onGetById;
  final AsyncValue<MachineSettingUpdateResponseModel?> onUpdate;
  const MachineSettingState({
    this.onGetAll = const AsyncValue.data([]),
    this.onGetById = const AsyncValue.data(null),
    this.onUpdate = const AsyncValue.data(null),
  });

  @override
  List<Object> get props => [onGetAll, onGetById, onUpdate];

  @override
  bool get stringify => true;

  MachineSettingState copyWith({
    AsyncValue<List<MachineSettingModel>>? onGetAll,
    AsyncValue<MachineSettingModel>? onGetById,
    AsyncValue<MachineSettingUpdateResponseModel>? onUpdate,
  }) {
    return MachineSettingState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onUpdate: onUpdate ?? this.onUpdate,
    );
  }
}

class MachineSettingNotifier extends StateNotifier<MachineSettingState> {
  final MachineSettingRepository repository;
  final String machineId;
  MachineSettingNotifier({
    required this.repository,
    required this.machineId,
  }) : super(const MachineSettingState()) {
    getAll();
  }

  Future<void> getAll() async {
    log("triggerrr");
    state = state.copyWith(onGetAll: const AsyncValue.loading());
    final result = await repository.getAll(machineId);
    result.fold(
      (failure) => state = state.copyWith(
          onGetAll: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncValue.data(data)),
    );
  }

  Future<MachineSettingState> getById({
    required String settingId,
  }) async {
    final result = await repository.getById(
      machineId: machineId,
      settingId: settingId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
          onGetById: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetById: AsyncValue.data(data)),
    );
  }

  Future<void> update({
    required FormMachineSettingCreateUpdateModel form,
    required String settingId,
    void Function()? onLoading,
    void Function(String message)? onError,
    void Function(MachineSettingUpdateResponseModel data)? onSuccess,
  }) async {
    state = state.copyWith(onUpdate: const AsyncValue.loading());
    if (onLoading != null) onLoading();
    final result = await repository.update(
      form: form,
      settingId: settingId,
    );
    result.fold(
      (failure) {
        if (onError != null) onError(failure.message);
        return state = state.copyWith(
            onUpdate: AsyncValue.error(failure.message, StackTrace.current));
      },
      (data) {
        if (onSuccess != null) onSuccess(data);
        return state = state.copyWith(onUpdate: AsyncValue.data(data));
      },
    );
  }
}
