import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_setting_remote_datasource.dart';
import '../model/form/form_machine_setting_create_update_model.dart';
import '../model/machine_setting/machine_setting_model.dart';
import '../model/machine_setting/machine_setting_update_response_model.dart';

class MachineSettingRepository {
  final MachineSettingRemoteDatasource remoteDatasource;
  const MachineSettingRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineSettingModel>>> getAll(
      String machineId) async {
    try {
      final result = await remoteDatasource.getAll(machineId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineSettingModel>> getById(String machineId) async {
    try {
      final result = await remoteDatasource.getById(machineId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineSettingUpdateResponseModel>> update({
    required FormMachineSettingCreateUpdateModel form,
    required String settingId,
  }) async {
    try {
      final result = await remoteDatasource.update(
        form: form,
        settingId: settingId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
