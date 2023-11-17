import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_group_remote_datasource.dart';
import '../model/helper/form/form_machine_group_create_update.model.dart';
import '../model/machine_group/machine_group.model.dart';

class MachineGroupRepository {
  final MachineGroupRemoteDatasource remoteDatasource;
  const MachineGroupRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineGroupModel>>> getAll(String userId) async {
    try {
      final result = await remoteDatasource.getAll(userId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel?>> getById({
    required String userId,
    required String machineGroupId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        userId: userId,
        machineGroupId: machineGroupId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel>> create(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    try {
      final result = await remoteDatasource.create(form);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel>> update(
    String machineGroupId,
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    try {
      final result = await remoteDatasource.update(machineGroupId, form);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel>> delete({
    required String userId,
    required String machineGroupId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        userId: userId,
        machineGroupId: machineGroupId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
