import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../../utils/flutter_secure_storage.dart';
import '../datasource/remote/authentication_remote_datasource.dart';
import '../model/authentication/authentication_response_model.dart';
import '../model/user/user_model.dart';

class AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  const AuthenticationRepository({
    required this.remoteDatasource,
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

      // save user to local storage when login success
      final (_, user) = result;
      await FlutterSecureStorageUtils.setUserAuth(user);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  // Local Data Source

  Future<Either<Failure, bool>> logout() async {
    try {
      // remove user from local storage
      await FlutterSecureStorageUtils.removeUserAuth();
      return const Right(true);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel?>> getUserLocalStorage() async {
    try {
      final result = await FlutterSecureStorageUtils.getUserAuth();
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
