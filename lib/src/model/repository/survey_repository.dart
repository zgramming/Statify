import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_remote_datasource.dart';
import '../model/survey/survey_by_machine_and_number_model.dart';
import '../model/survey/survey_create_response_model.dart';
import '../model/survey/survey_unlock_response_model.dart';

class SurveyRepository {
  final SurveyRemoteDatasource remoteDatasource;
  const SurveyRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyByMachineAndNumberModel>> getByMachineAndNumber({
    required String machineId,
    required String number,
  }) async {
    try {
      final result = await remoteDatasource.getByMachineAndNumber(
        machineId: machineId,
        number: number,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyCreateResponseModel>> create({
    required String number,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyUnlockResponseModel>> unlock({
    required String surveyId,
    required String key,
  }) async {
    try {
      final result = await remoteDatasource.unlock(
        surveyId: surveyId,
        key: key,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
