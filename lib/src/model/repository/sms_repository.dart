import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/sms_local_datasource.dart';
import '../model/sms_model.dart';

class SMSRepository {
  final SMSLocalDatasource localDatasource;
  const SMSRepository({
    required this.localDatasource,
  });

  Future<Either<Failure, String>> insert(SMSModel model) async {
    try {
      final result = await localDatasource.insert(model);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> delete(String id) async {
    try {
      final result = await localDatasource.delete(id);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  List<SMSModel> getAll() {
    return localDatasource.getAll();
  }
}
