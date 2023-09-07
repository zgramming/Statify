import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_response_remote_datasource.dart';
import '../model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../model/survey_response/survey_response_create_response_model.dart';
import '../model/survey_response/survey_response_fail_model.dart';
import '../model/survey_response/survey_response_sent_model.dart';

class SurveyResponseRepository {
  final SurveyResponseRemoteDatasource remoteDatasource;
  const SurveyResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyResponseByMachineAndTypeModel>>
      getByMachineAndType(String machineId) async {
    try {
      final response = await remoteDatasource.getByMachineAndType(machineId);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

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

  Future<Either<Failure, SurveyResponseSentModel>> sent(
    String surveyResponseId,
  ) async {
    try {
      final response = await remoteDatasource.sent(surveyResponseId);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseFailModel>> fail(
    String surveyResponseId,
  ) async {
    try {
      final response = await remoteDatasource.fail(surveyResponseId);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
