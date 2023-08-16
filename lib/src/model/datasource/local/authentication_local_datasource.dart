import '../../../utils/flutter_secure_storage.dart';
import '../../model/authentication/user_model.dart';

class AuthenticationLocalDatasource {
  Future<bool> saveUserLocalStorage(UserModel user) async {
    await FlutterSecureStorageUtils.setUserAuth(user);
    return true;
  }

  Future<bool> removeUserLocalStorage() async {
    await FlutterSecureStorageUtils.removeUserAuth();
    return true;
  }

  Future<UserModel?> loadUserLocalStorage() async {
    final result = await FlutterSecureStorageUtils.getUserAuth();
    return result;
  }
}
