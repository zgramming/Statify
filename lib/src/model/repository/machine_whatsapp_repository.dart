import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_whatsapp_remote_datasource.dart';
import '../model/machine_whatsapp/machine_whatsapp_connected_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_create_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_delete_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_disconnected_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_send_qrcode_response_model.dart';

class MachineWhatsappRepository {
  final MachineWhatsappRemoteDatasource remoteDatasource;
  const MachineWhatsappRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, MachineWhatsappCreateResponseModel>> create({
    required String number,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        machineId: machineId,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineWhatsappDeleteResponseModel>> delete(
    String machineWhatsappId,
  ) async {
    try {
      final result = await remoteDatasource.delete(machineWhatsappId);

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineWhatsappSendQRCodeResponseModel>> sendQRCode({
    required String number,
    required File file,
  }) async {
    try {
      final result = await remoteDatasource.sendQRCode(
        number: number,
        file: file,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineWhatsappDisconnectedResponseModel>> disconnect({
    required String machineWhatsappId,
  }) async {
    try {
      final result = await remoteDatasource.disconnect(
          machineWhatsappId: machineWhatsappId);

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineWhatsappConnectedResponseModel>> connect({
    required String machineWhatsappId,
  }) async {
    try {
      final result =
          await remoteDatasource.connect(machineWhatsappId: machineWhatsappId);

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
