import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/model/user/user_model.dart';
import 'constant.dart';

class FlutterSecureStorageUtils {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> setUserAuth(UserModel user) async {
    final map = user.toJson();
    final encode = jsonEncode(map);
    await FlutterSecureStorageUtils()._storage.write(
          key: kUserAuth,
          value: encode,
        );
  }

  static Future<UserModel?> getUserAuth() async {
    final result =
        await FlutterSecureStorageUtils()._storage.read(key: kUserAuth);

    if (result == null) {
      return null;
    }

    final decode = jsonDecode(result);
    final user = UserModel.fromJson(decode);

    return user;
  }

  static Future<String?> getTokenAuth() async {
    final result = await getUserAuth();
    final token = result?.token;

    return token;
  }

  static Future<void> removeUserAuth() async {
    await FlutterSecureStorageUtils()._storage.delete(
          key: kUserAuth,
        );
  }
}
