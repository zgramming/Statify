import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/authentication/authentication_response_model.dart';
import '../model/model/authentication/user_model.dart';
import '../model/repository/authentication_repository.dart';

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
