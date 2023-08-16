import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_remote_datasource.dart';
import '../model/machine/machine_create_response_model.dart';
import '../model/machine/machine_model.dart';

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

  Future<Either<Failure, MachineModel>> getById({
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

  Future<Either<Failure, MachineCreateResponseModel>> create({
    required String number,
    required String license,
    required String action,
    required String smsSetting,
    required String userId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        license: license,
        action: action,
        smsSetting: smsSetting,
        userId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
