import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/local/application_config_local_datasource.dart';
import '../model/application_config/application_config_model.dart';

class ApplicationConfigRepository {
  final ApplicationConfigLocalDatasource localDatasource;
  ApplicationConfigRepository({
    required this.localDatasource,
  });
  Future<Either<Failure, List<ApplicationConfigModel>>> getAll() async {
    try {
      final result = await localDatasource.getAll();
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, ApplicationConfigModel?>> getById(String id) async {
    try {
      final result = await localDatasource.getById(id);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, ApplicationConfigModel?>> getByKey(String key) async {
    try {
      final result = await localDatasource.getByKey(key);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> insert({
    required String key,
    required String value,
  }) async {
    try {
      final result = await localDatasource.insert(
        key: key,
        value: value,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> updateByKey({
    required String key,
    required String value,
  }) async {
    try {
      final result = await localDatasource.updateByKey(
        key: key,
        value: value,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, ApplicationConfigModel>> upsert({
    required String key,
    required String value,
  }) async {
    try {
      final result = await localDatasource.upsert(
        key: key,
        value: value,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> delete(String key) async {
    try {
      final result = await localDatasource.deleteByKey(key);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
