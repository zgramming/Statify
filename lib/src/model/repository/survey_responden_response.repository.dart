import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_responden_response_remote_datasource.dart';
import '../model/helper/form/form_survey_responden_response_create.model.dart';
import '../model/survey_responden_response/survey_responden_response_create_response_model.dart';
import '../model/survey_responden_response/survey_responden_response_fail_model.dart';
import '../model/survey_responden_response/survey_responden_response_sent_model.dart';

class SurveyRespondenResponseRepository {
  final SurveyRespondenResponseRemoteDatasource remoteDatasource;

  const SurveyRespondenResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyRespondenResponseCreateResponseModel>> create({
    required FormSurveyRespondenResponseCreateModel form,
  }) async {
    try {
      final response = await remoteDatasource.create(form: form);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyRespondenResponseSentModel>> sent({
    required String surveyRespondenId,
    required String surveyRespondenResponseId,
  }) async {
    try {
      final response = await remoteDatasource.sent(
        surveyRespondenId: surveyRespondenId,
        surveyRespondenResponseId: surveyRespondenResponseId,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyRespondenResponseFailModel>> fail({
    required String surveyRespondenId,
    required String surveyRespondenResponseId,
  }) async {
    try {
      final response = await remoteDatasource.fail(
        surveyRespondenId: surveyRespondenId,
        surveyRespondenResponseId: surveyRespondenResponseId,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
