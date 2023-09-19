import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_responden_remote_datasource.dart';
import '../model/survey_responden/survey_responden_create.model.dart';
import '../model/survey_responden/survey_responden_unlock.model.dart';

class SurveyRespondenRepository {
  final SurveyRespondenRemoteDatasource remoteDatasource;
  const SurveyRespondenRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyRespondenCreateModel>> create({
    required String number,
    required String surveyId,
    required String? key,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        surveyId: surveyId,
        key: key,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyRespondenUnlockModel>> unlock({
    required String surveyId,
    required String surveyRespondenId,
    required String key,
    required String platform,
  }) async {
    try {
      final result = await remoteDatasource.unlock(
        surveyId: surveyId,
        surveyRespondenId: surveyRespondenId,
        key: key,
        platform: platform,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
