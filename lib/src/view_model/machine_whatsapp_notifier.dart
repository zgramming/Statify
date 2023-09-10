import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/machine_whatsapp/machine_whatsapp_connected_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_create_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_delete_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_disconnected_response_model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_send_qrcode_response_model.dart';
import '../model/repository/machine_whatsapp_repository.dart';

class MachineWhatsappState extends Equatable {
  final AsyncValue<MachineWhatsappCreateResponseModel?> onCreate;
  final AsyncValue<MachineWhatsappDeleteResponseModel?> onDelete;
  final AsyncValue<MachineWhatsappSendQRCodeResponseModel?> onSendQRCode;
  final AsyncValue<MachineWhatsappDisconnectedResponseModel?> onDisconnect;
  final AsyncValue<MachineWhatsappConnectedResponseModel?> onConnect;

  const MachineWhatsappState({
    this.onCreate = const AsyncData(null),
    this.onDelete = const AsyncLoading(),
    this.onSendQRCode = const AsyncData(null),
    this.onDisconnect = const AsyncLoading(),
    this.onConnect = const AsyncLoading(),
  });

  @override
  List<Object> get props {
    return [
      onCreate,
      onDelete,
      onSendQRCode,
      onDisconnect,
      onConnect,
    ];
  }

  @override
  bool get stringify => true;

  MachineWhatsappState copyWith({
    AsyncValue<MachineWhatsappCreateResponseModel?>? onCreate,
    AsyncValue<MachineWhatsappDeleteResponseModel?>? onDelete,
    AsyncValue<MachineWhatsappSendQRCodeResponseModel?>? onSendQRCode,
    AsyncValue<MachineWhatsappDisconnectedResponseModel?>? onDisconnect,
    AsyncValue<MachineWhatsappConnectedResponseModel?>? onConnect,
  }) {
    return MachineWhatsappState(
      onCreate: onCreate ?? this.onCreate,
      onDelete: onDelete ?? this.onDelete,
      onSendQRCode: onSendQRCode ?? this.onSendQRCode,
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

  Future<void> create({
    required String number,
    required String machineId,
  }) async {
    state = const MachineWhatsappState(onCreate: AsyncLoading());

    final result = await repository.create(
      number: number,
      machineId: machineId,
    );

    result.fold(
      (failure) => state = MachineWhatsappState(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = MachineWhatsappState(onCreate: AsyncData(data)),
    );
  }

  Future<void> delete(
    String machineWhatsappId, {
    required VoidCallback onLoading,
    required void Function(String message) onError,
    required void Function(MachineWhatsappDeleteResponseModel data) onSuccess,
  }) async {
    onLoading();
    final result = await repository.delete(machineWhatsappId);

    result.fold(
      (failure) {
        onError(failure.message);
        return state = MachineWhatsappState(
            onDelete: AsyncError(failure.message, StackTrace.current));
      },
      (data) {
        onSuccess(data);
        return state = MachineWhatsappState(onDelete: AsyncData(data));
      },
    );
  }

  Future<void> sendQRCode({
    required String number,
    required File file,
  }) async {
    state = const MachineWhatsappState(onSendQRCode: AsyncLoading());

    final result = await repository.sendQRCode(
      number: number,
      file: file,
    );

    result.fold(
      (failure) => state = MachineWhatsappState(
          onSendQRCode: AsyncError(failure.message, StackTrace.current)),
      (data) => state = MachineWhatsappState(onSendQRCode: AsyncData(data)),
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
}
