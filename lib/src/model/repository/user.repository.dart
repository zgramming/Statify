import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../../utils/flutter_secure_storage.dart';
import '../datasource/remote/user_remote_datasource.dart';
import '../model/helper/form/form_user_update.model.dart';
import '../model/machine_whatsapp/machine_whatsapp_model.dart';
import '../model/survey/survey.model.dart';
import '../model/user/user_model.dart';
import '../model/user/user_update.model.dart';

class UserRepository {
  final UserRemoteDatasource remoteDatasource;
  const UserRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, UserModel?>> getById(String id) async {
    try {
      final user = await remoteDatasource.getById(id);
      return Right(user);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<SurveyModel>>> getAllSurvey(String userId) async {
    try {
      final surveys = await remoteDatasource.getAllSurvey(userId);
      return Right(surveys);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<MachineWhatsappModel>>> getAllWhatsApps(
      String userId) async {
    try {
      final whatsApps = await remoteDatasource.getAllWhatsApps(userId);
      return Right(whatsApps);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, (UserUpdateResponseModel, UserModel)>> update({
    required String userId,
    required FormUserUpdateModel form,
  }) async {
    try {
      final result = await remoteDatasource.update(
        userId: userId,
        form: form,
      );
      final (_, user) = result;
      // Save user to local storage
      await FlutterSecureStorageUtils.setUserAuth(user);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
