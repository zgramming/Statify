// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_machine_create_update.model.dart';
import '../model/model/helper/form/form_machine_update_config.model.dart';
import '../model/model/machine/machine_model.dart';
import '../model/repository/machine_repository.dart';
import '../utils/enum.dart';

class MachineState extends Equatable {
  final List<MachineModel> items;
  final AsyncValue<List<MachineModel>> onGetAll;
  final AsyncValue<MachineModel?> onGetByNumber;
  final AsyncValue<Uint8List?> onGetExport;
  final AsyncValue<List<String>?> onGetResults;
  final AsyncValue<MachineModel?> onCreate;
  final AsyncValue<MachineModel?> onUpdate;
  final AsyncValue<String?> onUpdateConfig;
  final AsyncValue<MachineModel?> onDelete;

  const MachineState({
    this.items = const [],
    this.onGetAll = const AsyncLoading(),
    this.onGetByNumber = const AsyncData(null),
    this.onGetExport = const AsyncData(null),
    this.onGetResults = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onUpdateConfig = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetAll,
      onGetByNumber,
      onGetExport,
      onGetResults,
      onCreate,
      onUpdate,
      onUpdateConfig,
      onDelete,
    ];
  }

  @override
  bool get stringify => true;

  MachineState copyWith({
    List<MachineModel>? items,
    AsyncValue<List<MachineModel>>? onGetAll,
    AsyncValue<MachineModel?>? onGetByNumber,
    AsyncValue<Uint8List?>? onGetExport,
    AsyncValue<List<String>?>? onGetResults,
    AsyncValue<MachineModel?>? onCreate,
    AsyncValue<MachineModel?>? onUpdate,
    AsyncValue<String?>? onUpdateConfig,
    AsyncValue<MachineModel?>? onDelete,
  }) {
    return MachineState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onGetExport: onGetExport ?? this.onGetExport,
      onGetResults: onGetResults ?? this.onGetResults,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onUpdateConfig: onUpdateConfig ?? this.onUpdateConfig,
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

  Future<MachineState> getAll() async {
    final result = await repository.getAll(userId);

    return result.fold(
      (failure) => state = state.copyWith(
        onGetAll: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(
        onGetAll: AsyncData(data),
        items: data,
      ),
    );
  }

  Future<MachineModel?> getById({
    required String machineId,
  }) async {
    final result = await repository.getById(
      userId: userId,
      machineId: machineId,
    );

    return result.fold(
      (failure) => throw failure.message,
      (data) => data,
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

  Future<MachineState> getExport({
    required String machineId,
    required ExportTypeEnum type,
  }) async {
    state = state.copyWith(onGetExport: const AsyncLoading());
    final result = await repository.getExport(
      machineId: machineId,
      type: type,
    );
    return result.fold(
      (failure) => state = state.copyWith(
          onGetExport: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetExport: AsyncData(data)),
    );
  }

  Future<MachineModel?> getByIP({
    required String machineId,
    required String ip,
  }) async {
    final result = await repository.getByIP(
      machineId: machineId,
      ip: ip,
    );

    return result.fold(
      (failure) => throw failure.message,
      (data) => data,
    );
  }

  Future<MachineState> getResults(String nameFileResult) async {
    state = state.copyWith(onGetResults: const AsyncLoading());
    final result = await repository.getResults(nameFileResult);

    return result.fold(
      (failure) => state = state.copyWith(
          onGetResults: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetResults: AsyncData(data)),
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
      (data) => state = state.copyWith(onUpdate: AsyncData(data), items: [
        ...state.items.map((element) {
          if (element.id == machineId) {
            return element.copyWith(
              license: data.license,
              name: data.name,
              number: data.number,
              activeSurveyId: data.activeSurveyId,
              serialNumber: data.serialNumber,
              userId: data.userId,
            );
          }
          return element;
        }),
      ]),
    );
  }

  Future<MachineState> updateConfig(FormMachineUpdateConfigModel form) async {
    state = state.copyWith(onUpdateConfig: const AsyncLoading());
    final result = await repository.updateConfig(form);
    final fold = result.fold(
      (failure) => state = state.copyWith(
          onUpdateConfig: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onUpdateConfig: AsyncData(data)),
    );

    return fold;
  }

  Future<MachineState> delete({
    required String machineId,
  }) async {
    state = state.copyWith(onDelete: const AsyncLoading());
    final result = await repository.delete(
      machineId: machineId,
      userId: userId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
          onDelete: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(
        onDelete: AsyncData(data),
        items: [
          ...state.items.where((element) => element.id != machineId),
        ],
      ),
    );
  }
}
