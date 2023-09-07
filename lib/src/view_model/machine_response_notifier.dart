// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/form/form_machine_response_create_update_model.dart';
import '../model/model/machine_response/machine_response_create_response_model.dart';
import '../model/model/machine_response/machine_response_delete_response_model.dart';
import '../model/model/machine_response/machine_response_model.dart';
import '../model/repository/machine_response_repository.dart';

class MachineResponseState extends Equatable {
  final AsyncValue<List<MachineResponseModel>> onGetAll;
  final AsyncValue<MachineResponseModel?> onGetById;
  final AsyncValue<MachineResponseCreateResponseModel?> onCreate;
  final AsyncValue<MachineResponseDeleteResponseModel?> onDelete;
  const MachineResponseState({
    this.onGetAll = const AsyncValue.data([]),
    this.onGetById = const AsyncValue.data(null),
    this.onCreate = const AsyncValue.data(null),
    this.onDelete = const AsyncValue.data(null),
  });

  @override
  List<Object> get props => [onGetAll, onGetById, onCreate, onDelete];

  @override
  bool get stringify => true;

  MachineResponseState copyWith({
    AsyncValue<List<MachineResponseModel>>? onGetAll,
    AsyncValue<MachineResponseModel?>? onGetById,
    AsyncValue<MachineResponseCreateResponseModel?>? onCreate,
    AsyncValue<MachineResponseDeleteResponseModel?>? onDelete,
  }) {
    return MachineResponseState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onCreate: onCreate ?? this.onCreate,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class MachineResponseNotifier extends StateNotifier<MachineResponseState> {
  MachineResponseNotifier({
    required this.repository,
    required this.machineId,
  }) : super(const MachineResponseState()) {
    getAll();
  }

  final MachineResponseRepository repository;
  final String machineId;

  Future<void> getAll() async {
    state = state.copyWith(onGetAll: const AsyncValue.loading());
    final result = await repository.getAll(machineId);
    result.fold(
      (failure) => state = state.copyWith(
          onGetAll: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncValue.data(data)),
    );
  }

  Future<void> getById({
    required String responseId,
  }) async {
    state = state.copyWith(onGetById: const AsyncValue.loading());
    final result = await repository.getById(
      machineId: machineId,
      responseId: responseId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onGetById: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetById: AsyncValue.data(data)),
    );
  }

  Future<void> create({
    required FormMachineResponseCreateUpdateModel form,
  }) async {
    state = state.copyWith(onCreate: const AsyncValue.loading());
    final result = await repository.create(
      form: form,
      machineId: machineId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncValue.data(data)),
    );
  }

  Future<void> delete({
    required String responseId,
  }) async {
    state = state.copyWith(onDelete: const AsyncValue.loading());
    final result = await repository.delete(
      machineId: machineId,
      responseId: responseId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onDelete: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onDelete: AsyncValue.data(data)),
    );
  }
}
