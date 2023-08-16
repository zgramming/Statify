import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_response_remote_datasource.dart';
import '../model/survey/survey_response_create_response_model.dart';
import '../model/survey/survey_response_model.dart';

class SurveyResponseRepository {
  final SurveyResponseRemoteDatasource remoteDatasource;
  const SurveyResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyResponseCreateResponseModel>> create({
    required String surveyId,
    required String key,
    required String type,
  }) async {
    try {
      final response = await remoteDatasource.create(
        surveyId: surveyId,
        key: key,
        type: type,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseModel>> getResponse({
    required String machineId,
  }) async {
    try {
      final response = await remoteDatasource.getResponse(
        machineId: machineId,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
