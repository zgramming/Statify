import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/authentication/authentication_response_model.dart';
import '../../model/user/user_model.dart';
import 'user_remote_datasource.dart';

class AuthenticationRemoteDatasource {
  final http.Client client;
  final UserRemoteDatasource userRemoteDatasource;

  const AuthenticationRemoteDatasource({
    required this.client,
    required this.userRemoteDatasource,
  });

  Future<(AuthenticationResponseModel, UserModel)> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/auth");
    final response = await client.post(uri, body: {
      'username': username,
      'password': password,
    }).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception('Connection timeout'),
    );
    final body = response.body;

    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];

      final authenticationResponseModel =
          AuthenticationResponseModel.fromJson(data);

      final user =
          await userRemoteDatasource.me(authenticationResponseModel.token);

      return (authenticationResponseModel, user);
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to login';
      throw Exception(message);
    }
  }
}
