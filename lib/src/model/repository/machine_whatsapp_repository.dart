import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_whatsapp_remote_datasource.dart';
import '../model/machine/machine_whatsapp_create_response_model.dart';
import '../model/machine/machine_whatsapp_send_qrcode_response_model.dart';

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
}
