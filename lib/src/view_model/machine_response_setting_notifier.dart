import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/machine/machine_response_setting_create_response_model.dart';
import '../model/model/machine/machine_response_setting_model.dart';
import '../model/model/machine_response_setting/machine_response_setting_delete_response_model.dart';
import '../model/repository/machine_response_setting_repository.dart';

class MachineResponseSettingState extends Equatable {
  final AsyncValue<List<MachineResponseSettingModel>> onGetAll;
  final AsyncValue<MachineResponseSettingCreateResponseModel?> onCreate;
  final AsyncValue<MachineResponseSettingDeleteResponseModel?> onDelete;

  const MachineResponseSettingState({
    this.onGetAll = const AsyncData([]),
    this.onCreate = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object> get props => [onGetAll, onCreate, onDelete];

  @override
  bool get stringify => true;

  MachineResponseSettingState copyWith({
    AsyncValue<List<MachineResponseSettingModel>>? onGetAll,
    AsyncValue<MachineResponseSettingCreateResponseModel?>? onCreate,
    AsyncValue<MachineResponseSettingDeleteResponseModel?>? onDelete,
  }) {
    return MachineResponseSettingState(
      onGetAll: onGetAll ?? this.onGetAll,
      onCreate: onCreate ?? this.onCreate,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class MachineResponseSettingNotifier
    extends StateNotifier<MachineResponseSettingState> {
  final MachineResponseSettingRepository repository;
  final String idMachine;

  MachineResponseSettingNotifier({
    required this.repository,
    required this.idMachine,
  }) : super(const MachineResponseSettingState());

  Future<void> getAll() async {
    state = state.copyWith(onGetAll: const AsyncLoading());
    final result = await repository.getAll(idMachine);

    result.fold(
      (failure) => state = state.copyWith(
          onGetAll: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncData(data)),
    );
  }

  Future<void> create({
    required String key,
    required String value,
    required String type,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      key: key,
      value: value,
      type: type,
      idMachine: idMachine,
    );

    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<void> delete({
    required String idResponseSetting,
  }) async {
    state = state.copyWith(onDelete: const AsyncLoading());
    final result = await repository.delete(
      idMachine: idMachine,
      idResponseSetting: idResponseSetting,
    );

    result.fold(
      (failure) => state = state.copyWith(
          onDelete: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onDelete: AsyncData(data)),
    );
  }
}
