import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/local/authentication_local_datasource.dart';
import '../datasource/remote/authentication_remote_datasource.dart';
import '../model/authentication/authentication_response_model.dart';
import '../model/authentication/user_model.dart';

class AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  final AuthenticationLocalDatasource localDatasource;
  const AuthenticationRepository({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  Future<Either<Failure, (AuthenticationResponseModel, UserModel)>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await remoteDatasource.login(
        username: username,
        password: password,
      );

      // save user to local storage
      final (_, user) = result;
      await localDatasource.saveUserLocalStorage(user);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> me(String token) async {
    try {
      final result = await remoteDatasource.me(token);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  // Local Data Source

  Future<Either<Failure, bool>> logout() async {
    try {
      // remove user from local storage
      await localDatasource.removeUserLocalStorage();
      return const Right(true);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel?>> getUserLocalStorage() async {
    try {
      final result = await localDatasource.loadUserLocalStorage();
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
