import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_setting_remote_datasource.dart';
import '../model/helper/form/form_survey_setting_create_update.model.dart';
import '../model/survey_setting/survey_setting_model.dart';

class SurveySettingRepository {
  final SurveySettingRemoteDatasource remoteDatasource;
  const SurveySettingRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<SurveySettingModel>>> getAll(
      String machineId) async {
    try {
      final result = await remoteDatasource.getAll(machineId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveySettingModel>> getById({
    required String settingId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        surveyId: surveyId,
        settingId: settingId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveySettingModel>> update({
    required FormSurveySettingCreateUpdateModel form,
    required String settingId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.update(
        form: form,
        settingId: settingId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
