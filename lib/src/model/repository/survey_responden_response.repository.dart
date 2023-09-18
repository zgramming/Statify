import 'package:dartz/dartz.dart';

import '../../utils/enum.dart';
import '../../utils/failure.dart';
import '../datasource/remote/survey_responden_response_remote_datasource.dart';
import '../model/helper/form/form_survey_response_create_model.dart';
import '../model/survey_responden_response/survey_responden_response_create_response_model.dart';
import '../model/survey_responden_response/survey_responden_response_pending_response.model.dart';
import '../model/survey_responden_response/survey_responden_response_fail_model.dart';
import '../model/survey_responden_response/survey_responden_response_sent_model.dart';

class SurveyRespondenResponseRepository {
  final SurveyRespondenResponseRemoteDatasource remoteDatasource;

  const SurveyRespondenResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyRespondenResponsePendingResponseModel?>>
      getPendingResponse(
          String machineId, MachineResponsePlatformEnum platform) async {
    try {
      final response =
          await remoteDatasource.getPendingResponse(machineId, platform);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyRespondenResponseCreateResponseModel>> create(
      FormSurveyResponseCreateModel form) async {
    try {
      final response = await remoteDatasource.create(form);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyRespondenResponseSentModel>> sent(
    String surveyResponseId,
  ) async {
    try {
      final response = await remoteDatasource.sent(surveyResponseId);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyRespondenResponseFailModel>> fail(
    String surveyResponseId,
  ) async {
    try {
      final response = await remoteDatasource.fail(surveyResponseId);
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Either<Failure, Stream<String?>> listenPendingResponse({
    required String machineId,
    required int simSlot,
  }) {
    try {
      final response = remoteDatasource.listenPendingResponse(
        machineId: machineId,
        simSlot: simSlot,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
