import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_machine_create_update_model.dart';
import '../model/model/machine/machine_create_response_model.dart';
import '../model/model/machine/machine_delete_response_model.dart';
import '../model/model/machine/machine_model.dart';
import '../model/model/machine/machine_update_response_model.dart';
import '../model/repository/machine_repository.dart';

class MachineState extends Equatable {
  final AsyncValue<List<MachineModel>> onGetAll;
  final AsyncValue<MachineModel?> onGetById;
  final AsyncValue<MachineModel?> onGetByNumber;
  final AsyncValue<MachineCreateResponseModel?> onCreate;
  final AsyncValue<MachineUpdateResponseModel?> onUpdate;
  final AsyncValue<MachineDeleteResponseModel?> onDelete;

  const MachineState({
    this.onGetAll = const AsyncLoading(),
    this.onGetById = const AsyncData(null),
    this.onGetByNumber = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      onGetAll,
      onGetById,
      onGetByNumber,
      onCreate,
      onUpdate,
      onDelete,
    ];
  }

  @override
  bool get stringify => true;

  MachineState copyWith({
    AsyncValue<List<MachineModel>>? onGetAll,
    AsyncValue<MachineModel?>? onGetById,
    AsyncValue<MachineModel?>? onGetByNumber,
    AsyncValue<MachineCreateResponseModel?>? onCreate,
    AsyncValue<MachineUpdateResponseModel?>? onUpdate,
    AsyncValue<MachineDeleteResponseModel?>? onDelete,
  }) {
    return MachineState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class MachineNotifier extends StateNotifier<MachineState> {
  final MachineRepository repository;
  final String userId;
  MachineNotifier({
    required this.repository,
    required this.userId,
  }) : super(const MachineState()) {
    getAll();
  }

  Future<void> getAll() async {
    final result = await repository.getAll(userId);

    if (mounted) {
      result.fold(
        (failure) => state = state.copyWith(
            onGetAll: AsyncError(failure.message, StackTrace.current)),
        (data) => state = state.copyWith(onGetAll: AsyncData(data)),
      );
    }
  }

  Future<void> getById({
    required String machineId,
  }) async {
    state = state.copyWith(onGetById: const AsyncLoading());
    final result = await repository.getById(
      userId: userId,
      machineId: machineId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onGetById: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetById: AsyncData(data)),
    );
  }

  Future<void> getByNumber({
    required String machineNumber,
  }) async {
    state = state.copyWith(onGetByNumber: const AsyncLoading());
    final result = await repository.getByNumber(
      userId: userId,
      machineNumber: machineNumber,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onGetByNumber: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetByNumber: AsyncData(data)),
    );
  }

  Future<void> create(FormMachineCreateUpdateModel form) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(form: form, userId: userId);
    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<void> update({
    required String machineId,
    required FormMachineCreateUpdateModel form,
  }) async {
    state = state.copyWith(onUpdate: const AsyncLoading());
    final result = await repository.update(
      machineId: machineId,
      form: form,
      userId: userId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onUpdate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onUpdate: AsyncData(data)),
    );
  }

  Future<void> delete({
    required String machineId,
  }) async {
    state = state.copyWith(onDelete: const AsyncLoading());
    final result = await repository.delete(
      machineId: machineId,
      userId: userId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onDelete: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onDelete: AsyncData(data)),
    );
  }
}
