// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/authentication/authentication_response_model.dart';
import '../../model/authentication/user_model.dart';

class AuthenticationRemoteDatasource {
  final http.Client client;

  const AuthenticationRemoteDatasource({
    required this.client,
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

      final user = await me(authenticationResponseModel.token);

      return (authenticationResponseModel, user);
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to login';
      throw Exception(message);
    }
  }

  Future<UserModel> me(String token) async {
    final uri = Uri.parse("$kBaseApiUrl/users/me");
    final response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final userModel = UserModel.fromJson(data);
      return userModel.copyWith(token: token);
    } else {
      throw Exception('Failed to get user');
    }
  }
}
