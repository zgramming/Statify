import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/model/authentication/user_model.dart';
import 'constant.dart';

class FlutterSecureStorageUtils {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> setTokenAuth(String token) async {
    await FlutterSecureStorageUtils()
        ._storage
        .write(key: kTokenAuth, value: token);
  }

  static Future<String> getTokenAuth() async {
    final result =
        await FlutterSecureStorageUtils()._storage.read(key: kTokenAuth);

    if (result == null) {
      throw Exception('Token not found');
    }

    return result;
  }

  static Future<void> removeTokenAuth() async {
    await FlutterSecureStorageUtils()._storage.delete(key: kTokenAuth);
  }

  static Future<void> setUserAuth(UserModel user) async {
    final map = user.toJson();
    final encode = jsonEncode(map);
    await FlutterSecureStorageUtils()._storage.write(
          key: kUserAuth,
          value: encode,
        );
  }

  static Future<UserModel> getUserAuth() async {
    final result =
        await FlutterSecureStorageUtils()._storage.read(key: kUserAuth);

    if (result == null) {
      throw Exception('User not found');
    }

    final decode = jsonDecode(result);
    final user = UserModel.fromJson(decode);

    return user;
  }

  static Future<void> removeUserAuth() async {
    await FlutterSecureStorageUtils()._storage.delete(key: kUserAuth);
  }
}
