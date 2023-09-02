// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/machine/machine_create_response_model.dart';
import '../model/model/machine/machine_model.dart';
import '../model/repository/machine_repository.dart';

class MachineState extends Equatable {
  final AsyncValue<List<MachineModel>> onGetAll;
  final AsyncValue<MachineModel?> onGetById;
  final AsyncValue<MachineModel?> onGetByNumber;
  final AsyncValue<MachineCreateResponseModel?> onCreate;
  const MachineState({
    this.onGetAll = const AsyncData([]),
    this.onGetById = const AsyncData(null),
    this.onGetByNumber = const AsyncData(null),
    this.onCreate = const AsyncData(null),
  });

  @override
  List<Object> get props => [onGetAll, onGetById, onGetByNumber, onCreate];

  @override
  bool get stringify => true;

  MachineState copyWith({
    AsyncValue<List<MachineModel>>? onGetAll,
    AsyncValue<MachineModel?>? onGetById,
    AsyncValue<MachineModel?>? onGetByNumber,
    AsyncValue<MachineCreateResponseModel?>? onCreate,
  }) {
    return MachineState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onCreate: onCreate ?? this.onCreate,
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
    state = state.copyWith(onGetAll: const AsyncLoading());
    final result = await repository.getAll(userId);
    result.fold(
      (failure) => state = state.copyWith(
          onGetAll: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncData(data)),
    );
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

  Future<void> create({
    required String number,
    required String license,
    required String action,
    required String smsSetting,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      number: number,
      license: license,
      action: action,
      smsSetting: smsSetting,
      userId: userId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }
}
