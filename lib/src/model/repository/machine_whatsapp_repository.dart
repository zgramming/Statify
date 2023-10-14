import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../utils/enum.dart';
import '../../utils/failure.dart';
import '../datasource/remote/machine_whatsapp_remote_datasource.dart';
import '../model/helper/form/form_machine_whatsapp_create_update.model.dart';
import '../model/machine_whatsapp/machine_whatsapp_connected_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_create_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_delete_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_disconnected_response_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_model.dart';
import '../model/machine_whatsapp/machine_whatsapp_update_response_model.dart';

class MachineWhatsappRepository {
  final MachineWhatsappRemoteDatasource remoteDatasource;
  const MachineWhatsappRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, MachineWhatsappModel>> getById(String id) async {
    try {
      final result = await remoteDatasource.getById(id);

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, Uint8List>> getExport({
    required String whatsappId,
    required ExportTypeEnum type,
  }) async {
    try {
      final result = await remoteDatasource.getExport(
        whatsappId: whatsappId,
        type: type,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineWhatsappCreateResponseModel>> create(
      FormMachineWhatsappCreateOrUpdateModel form) async {
    try {
      final result = await remoteDatasource.create(form);

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineWhatsappUpdateResponseModel>> update(
    FormMachineWhatsappCreateOrUpdateModel form,
  ) async {
    try {
      final result = await remoteDatasource.update(form);

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
