import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/machine/machine_whatsapp_create_response_model.dart';
import '../model/model/machine/machine_whatsapp_send_qrcode_response_model.dart';
import '../model/repository/machine_whatsapp_repository.dart';

class MachineWhatsappState extends Equatable {
  final AsyncValue<MachineWhatsappCreateResponseModel?> onCreate;
  final AsyncValue<MachineWhatsappSendQRCodeResponseModel?> onSendQRCode;
  const MachineWhatsappState({
    this.onCreate = const AsyncData(null),
    this.onSendQRCode = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate];

  @override
  bool get stringify => true;
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
}
