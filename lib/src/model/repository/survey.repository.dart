import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../utils/enum.dart';
import '../../utils/failure.dart';
import '../datasource/remote/survey_remote_datasource.dart';
import '../model/helper/form/form_survey_create_update.model.dart';
import '../model/survey/survey.model.dart';
import '../model/survey/survey_summary.model.dart';

class SurveyRepository {
  final SurveyRemoteDatasource remoteDatasource;
  const SurveyRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<SurveyModel>>> getAll({
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.getAll(
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel?>> getById({
    required String machineId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        machineId: machineId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> getByNumber({
    required String number,
  }) async {
    try {
      final result = await remoteDatasource.getByNumber(
        number: number,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<SurveySummaryModel>>> getVotingSummary({
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.getVotingSummary(
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, Uint8List>> getExport({
    required String surveyId,
    required ExportTypeEnum type,
  }) async {
    try {
      final result = await remoteDatasource.getExport(
        surveyId: surveyId,
        type: type,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> create({
    required String machineId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    try {
      final result = await remoteDatasource.create(
        machineId: machineId,
        form: form,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> update({
    required String machineId,
    required String surveyId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    try {
      final result = await remoteDatasource.update(
        machineId: machineId,
        surveyId: surveyId,
        form: form,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> active({
    required String machineId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.active(
        machineId: machineId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> delete({
    required String machineId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        machineId: machineId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> reset({
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.reset(surveyId: surveyId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Stream<String?> listenPendingResponse({
    required int simSlot,
    required String surveyId,
  }) {
    final result = remoteDatasource.listenPendingResponse(
      simSlot: simSlot,
      surveyId: surveyId,
    );

    return result;
  }
}
