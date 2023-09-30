import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_response_remote_datasource.dart';
import '../model/helper/form/form_machine_response_create_update.model.dart';
import '../model/survey_response/survey_response_create_response_model.dart';
import '../model/survey_response/survey_response_model.dart';

class SurveyResponseRepository {
  final SurveyResponseRemoteDatasource remoteDatasource;
  const SurveyResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<SurveyResponseModel>>> getAll(
      String machineId) async {
    try {
      final result = await remoteDatasource.getAll(machineId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseModel>> getById({
    required String surveyId,
    required String responseId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        surveyId: surveyId,
        responseId: responseId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseCreateModel>> create({
    required FormMachineResponseCreateUpdateModel form,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        form: form,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseModel>> update({
    required FormMachineResponseCreateUpdateModel form,
    required String responseId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.update(
        form: form,
        surveyId: surveyId,
        responseId: responseId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseModel>> delete({
    required String responseId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        surveyId: surveyId,
        responseId: responseId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
