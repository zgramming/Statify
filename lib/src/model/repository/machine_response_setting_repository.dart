import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_response_setting_remote_datasource.dart';
import '../model/machine/machine_response_setting_create_response_model.dart';
import '../model/machine/machine_response_setting_model.dart';

class MachineResponseSettingRepository {
  final MachineResponseSettingRemoteDatasource remoteDatasource;
  const MachineResponseSettingRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineResponseSettingModel>>> getAll(
      String idMachine) async {
    try {
      final result = await remoteDatasource.getAll(idMachine);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineResponseSettingCreateResponseModel>> create({
    required String key,
    required String value,
    required String type,
    required String idMachine,
  }) async {
    try {
      final result = await remoteDatasource.create(
        key: key,
        value: value,
        type: type,
        idMachine: idMachine,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
