import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../../utils/token.dart';
import '../../model/authentication/authentication_response_model.dart';
import '../../model/authentication/user_model.dart';

class AuthenticationRemoteDatasource {
  final http.Client client;
  const AuthenticationRemoteDatasource({
    required this.client,
  });

  Future<AuthenticationResponseModel> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/auth");
    final response = await client.post(
      uri,
      body: {
        'email': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = response.body;
      final decodedData = Map<String, dynamic>.from(jsonDecode(data));
      final authenticationResponseModel =
          AuthenticationResponseModel.fromJson(decodedData);

      // Save token to secure storage
      await FlutterSecureStorageUtils.setTokenAuth(
        authenticationResponseModel.token,
      );

      // Save user to secure storage
      final user = await me(authenticationResponseModel.token);
      await FlutterSecureStorageUtils.setUserAuth(user);

      return authenticationResponseModel;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<UserModel> me(String token) async {
    final uri = Uri.parse("$kBaseApiUrl/users/me");
    final response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = response.body;
      final decodedData = Map<String, dynamic>.from(jsonDecode(data));
      final userModel = UserModel.fromJson(decodedData);
      return userModel;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<void> logout() async {
    // Remove token from secure storage
    await FlutterSecureStorageUtils.removeTokenAuth();
  }
}

class AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  const AuthenticationRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, AuthenticationResponseModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final authenticationResponseModel = await remoteDatasource.login(
        username: username,
        password: password,
      );

      return Right(authenticationResponseModel);
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
}

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.onLogin = const AsyncData(null),
    this.onMe = const AsyncData(null),
  });

  final AsyncValue<AuthenticationResponseModel?> onLogin;
  final AsyncValue<UserModel?> onMe;

  @override
  List<Object> get props => [onLogin, onMe];

  @override
  bool get stringify => true;

  AuthenticationState copyWith({
    AsyncValue<AuthenticationResponseModel?>? onLogin,
    AsyncValue<UserModel?>? onMe,
  }) {
    return AuthenticationState(
      onLogin: onLogin ?? this.onLogin,
      onMe: onMe ?? this.onMe,
    );
  }
}

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final AuthenticationRepository repository;
  AuthenticationNotifier({
    required this.repository,
  }) : super(const AuthenticationState());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(onLogin: const AsyncLoading());
    final result = await repository.login(
      username: username,
      password: password,
    );
    result.fold(
      (failure) => state =
          state.copyWith(onLogin: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onLogin: AsyncData(data)),
    );
  }

  Future<void> me(String token) async {
    state = state.copyWith(onMe: const AsyncLoading());
    final result = await repository.me(token);
    result.fold(
      (failure) =>
          state = state.copyWith(onMe: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onMe: AsyncData(data)),
    );
  }
}
