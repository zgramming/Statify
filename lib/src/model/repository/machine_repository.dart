import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../utils/enum.dart';
import '../../utils/failure.dart';
import '../datasource/remote/machine_remote_datasource.dart';
import '../model/helper/form/form_machine_create_update.model.dart';
import '../model/machine/machine_create_response_model.dart';
import '../model/machine/machine_delete_response_model.dart';
import '../model/machine/machine_model.dart';
import '../model/machine/machine_update_response_model.dart';

class MachineRepository {
  final MachineRemoteDatasource remoteDatasource;
  const MachineRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineModel>>> getAll(String userId) async {
    try {
      final result = await remoteDatasource.getAll(userId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineModel?>> getById({
    required String userId,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        userId: userId,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineModel>> getByNumber({
    required String userId,
    required String machineNumber,
  }) async {
    try {
      final result = await remoteDatasource.getByNumber(
        userId: userId,
        machineNumber: machineNumber,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, Uint8List>> getExport({
    required String machineId,
    required ExportTypeEnum type,
  }) async {
    try {
      final result = await remoteDatasource.getExport(
        machineId: machineId,
        type: type,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineCreateResponseModel>> create({
    required FormMachineCreateUpdateModel form,
    required String userId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        form: form,
        userId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineUpdateResponseModel>> update({
    required String machineId,
    required String userId,
    required FormMachineCreateUpdateModel form,
  }) async {
    try {
      final result = await remoteDatasource.update(
        form: form,
        userId: userId,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineDeleteResponseModel>> delete({
    required String userId,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        userId: userId,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
