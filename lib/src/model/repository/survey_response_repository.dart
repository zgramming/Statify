import 'package:dartz/dartz.dart';

import '../../utils/enum.dart';
import '../../utils/failure.dart';
import '../datasource/remote/survey_response_remote_datasource.dart';
import '../model/form/form_survey_response_create_model.dart';
import '../model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../model/survey_response/survey_response_create_response_model.dart';
import '../model/survey_response/survey_response_fail_model.dart';
import '../model/survey_response/survey_response_sent_model.dart';

class SurveyResponseRepository {
  final SurveyResponseRemoteDatasource remoteDatasource;

  const SurveyResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyResponseByMachineAndTypeModel?>>
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

  Future<Either<Failure, SurveyResponseCreateResponseModel>> create(
      FormSurveyResponseCreateModel form) async {
    try {
      final response = await remoteDatasource.create(form);
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
