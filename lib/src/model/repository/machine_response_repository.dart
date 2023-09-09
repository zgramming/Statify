import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_response_remote_datasource.dart';
import '../model/form/form_machine_response_create_update_model.dart';
import '../model/machine_response/machine_response_create_response_model.dart';
import '../model/machine_response/machine_response_delete_response_model.dart';
import '../model/machine_response/machine_response_model.dart';
import '../model/machine_response/machine_response_update_response_model.dart';

class MachineResponseRepository {
  final MachineResponseRemoteDatasource remoteDatasource;
  const MachineResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineResponseModel>>> getAll(
      String machineId) async {
    try {
      final result = await remoteDatasource.getAll(machineId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineResponseModel>> getById({
    required String machineId,
    required String responseId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        machineId: machineId,
        responseId: responseId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineResponseCreateResponseModel>> create({
    required FormMachineResponseCreateUpdateModel form,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        form: form,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineResponseUpdateResponseModel>> update({
    required FormMachineResponseCreateUpdateModel form,
    required String machineId,
    required String responseId,
  }) async {
    try {
      final result = await remoteDatasource.update(
        form: form,
        machineId: machineId,
        responseId: responseId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineResponseDeleteResponseModel>> delete({
    required String machineId,
    required String responseId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        machineId: machineId,
        responseId: responseId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
