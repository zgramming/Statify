import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/survey_remote_datasource.dart';
import '../model/survey/survey_create_response_model.dart';

class SurveyRepository {
  final SurveyRemoteDatasource remoteDatasource;
  const SurveyRepository({
    required this.remoteDatasource,
  });

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
}
