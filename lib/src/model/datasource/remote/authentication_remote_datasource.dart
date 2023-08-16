// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/authentication/authentication_response_model.dart';
import '../../model/authentication/user_model.dart';
import '../local/authentication_local_datasource.dart';

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
    });

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

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.onLogin = const AsyncData(null),
    this.onLogout = const AsyncData(false),
    this.onMe = const AsyncData(null),
    this.user,
  });

  final AsyncValue<AuthenticationResponseModel?> onLogin;
  final AsyncValue<bool> onLogout;
  final AsyncValue<UserModel?> onMe;
  final UserModel? user;

  @override
  List<Object?> get props => [onLogin, onLogout, onMe, user];

  @override
  bool get stringify => true;

  AuthenticationState copyWith({
    AsyncValue<AuthenticationResponseModel?>? onLogin,
    AsyncValue<bool>? onLogout,
    AsyncValue<UserModel?>? onMe,
    UserModel? user,
  }) {
    return AuthenticationState(
      onLogin: onLogin ?? this.onLogin,
      onLogout: onLogout ?? this.onLogout,
      onMe: onMe ?? this.onMe,
      user: user ?? this.user,
    );
  }
}

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final AuthenticationRepository repository;
  AuthenticationNotifier({
    required this.repository,
  }) : super(const AuthenticationState());

  Future<UserModel?> getUserLocalStorage() async {
    final result = await repository.getUserLocalStorage();
    final fold = result.fold(
      (failure) => state = state.copyWith(user: null),
      (data) => state = state.copyWith(user: data),
    );

    return fold.user;
  }

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
      (data) {
        final (authenticationResponseModel, user) = data;
        return state = state.copyWith(
          onLogin: AsyncData(authenticationResponseModel),
          user: user,
        );
      },
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

  Future<void> logout() async {
    state = state.copyWith(onLogout: const AsyncLoading());
    final result = await repository.logout();
    result.fold(
      (failure) => state =
          state.copyWith(onLogout: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onLogout: AsyncData(data)),
    );
  }
}
