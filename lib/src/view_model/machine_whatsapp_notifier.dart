import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_machine_whatsapp_create_update.model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_connected_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_create_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_delete_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_disconnected_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_update_response_model.dart';
import '../model/repository/machine_whatsapp_repository.dart';
import '../utils/enum.dart';

class MachineWhatsappState extends Equatable {
  final List<MachineWhatsappModel> items;
  final AsyncValue<MachineWhatsappModel?> onGetById;
  final AsyncValue<Uint8List?> onGetExport;
  final AsyncValue<MachineWhatsappCreateResponseModel?> onCreate;
  final AsyncValue<MachineWhatsappUpdateResponseModel?> onUpdate;
  final AsyncValue<MachineWhatsappDeleteResponseModel?> onDelete;
  final AsyncValue<MachineWhatsappDisconnectedResponseModel?> onDisconnect;
  final AsyncValue<MachineWhatsappConnectedResponseModel?> onConnect;

  const MachineWhatsappState({
    this.items = const [],
    this.onGetById = const AsyncData(null),
    this.onGetExport = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onDelete = const AsyncData(null),
    this.onDisconnect = const AsyncData(null),
    this.onConnect = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetById,
      onGetExport,
      onCreate,
      onUpdate,
      onDelete,
      onDisconnect,
      onConnect,
    ];
  }

  @override
  bool get stringify => true;

  MachineWhatsappState copyWith({
    List<MachineWhatsappModel>? items,
    AsyncValue<MachineWhatsappModel?>? onGetById,
    AsyncValue<Uint8List?>? onGetExport,
    AsyncValue<MachineWhatsappCreateResponseModel?>? onCreate,
    AsyncValue<MachineWhatsappUpdateResponseModel?>? onUpdate,
    AsyncValue<MachineWhatsappDeleteResponseModel?>? onDelete,
    AsyncValue<MachineWhatsappDisconnectedResponseModel?>? onDisconnect,
    AsyncValue<MachineWhatsappConnectedResponseModel?>? onConnect,
  }) {
    return MachineWhatsappState(
      items: items ?? this.items,
      onGetById: onGetById ?? this.onGetById,
      onGetExport: onGetExport ?? this.onGetExport,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onDelete: onDelete ?? this.onDelete,
      onDisconnect: onDisconnect ?? this.onDisconnect,
      onConnect: onConnect ?? this.onConnect,
    );
  }
}

class MachineWhatsappNotifier extends StateNotifier<MachineWhatsappState> {
  final MachineWhatsappRepository repository;
  MachineWhatsappNotifier({
    required this.repository,
  }) : super(const MachineWhatsappState());

  Future<MachineWhatsappState> getById(String id) async {
    state = const MachineWhatsappState(onGetById: AsyncLoading());

    final result = await repository.getById(id);

    return result.fold(
      (failure) => state = MachineWhatsappState(
          onGetById: AsyncError(failure.message, StackTrace.current)),
      (data) => state = MachineWhatsappState(onGetById: AsyncData(data)),
    );
  }

  Future<MachineWhatsappState> getExport({
    required String machineWhatsappId,
    required ExportTypeEnum type,
  }) async {
    state = const MachineWhatsappState(onGetExport: AsyncLoading());

    final result = await repository.getExport(
      whatsappId: machineWhatsappId,
      type: type,
    );

    return result.fold(
      (failure) => state = MachineWhatsappState(
          onGetExport: AsyncError(failure.message, StackTrace.current)),
      (data) => state = MachineWhatsappState(onGetExport: AsyncData(data)),
    );
  }

  Future<MachineWhatsappState> create(
      FormMachineWhatsappCreateOrUpdateModel form) async {
    state = const MachineWhatsappState(onCreate: AsyncLoading());

    final result = await repository.create(form);

    return result.fold(
      (failure) => state = MachineWhatsappState(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = MachineWhatsappState(onCreate: AsyncData(data)),
    );
  }

  Future<MachineWhatsappState> update(
    FormMachineWhatsappCreateOrUpdateModel form,
  ) async {
    state = const MachineWhatsappState(onUpdate: AsyncLoading());

    final result = await repository.update(form);

    return result.fold(
      (failure) => state = MachineWhatsappState(
          onUpdate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = MachineWhatsappState(onUpdate: AsyncData(data)),
    );
  }

  Future<MachineWhatsappState> delete(String machineWhatsappId) async {
    final result = await repository.delete(machineWhatsappId);

    return result.fold(
      (failure) {
        return state = MachineWhatsappState(
            onDelete: AsyncError(failure.message, StackTrace.current));
      },
      (data) {
        return state = MachineWhatsappState(onDelete: AsyncData(data));
      },
    );
  }

  Future<void> disconnect({
    required String machineWhatsappId,
    required VoidCallback onLoading,
    required void Function(String message) onError,
    required void Function(MachineWhatsappDisconnectedResponseModel data)
        onSuccess,
  }) async {
    onLoading();
    final result = await repository.disconnect(
      machineWhatsappId: machineWhatsappId,
    );

    result.fold(
      (failure) {
        onError(failure.message);
        return state = MachineWhatsappState(
            onDisconnect: AsyncError(failure.message, StackTrace.current));
      },
      (data) {
        onSuccess(data);
        return state = MachineWhatsappState(onDisconnect: AsyncData(data));
      },
    );
  }

  Future<void> connect({
    required String machineWhatsappId,
    required VoidCallback onLoading,
    required void Function(String message) onError,
    required void Function(MachineWhatsappConnectedResponseModel data)
        onSuccess,
  }) async {
    onLoading();
    final result = await repository.connect(
      machineWhatsappId: machineWhatsappId,
    );

    result.fold(
      (failure) {
        onError(failure.message);
        return state = MachineWhatsappState(
            onConnect: AsyncError(failure.message, StackTrace.current));
      },
      (data) {
        onSuccess(data);
        return state = MachineWhatsappState(onConnect: AsyncData(data));
      },
    );
  }

  void resetItems() {
    state = state.copyWith(items: []);
  }

  void setItems(List<MachineWhatsappModel> items) {
    state = state.copyWith(
      items: [
        ...state.items,
        ...items,
      ],
    );
  }
}
