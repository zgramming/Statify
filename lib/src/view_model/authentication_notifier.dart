import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/authentication/authentication_response_model.dart';
import '../model/model/user/user_model.dart';
import '../model/repository/authentication_repository.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.onLogin = const AsyncData(null),
    this.onLogout = const AsyncData(false),
  });

  final AsyncValue<(AuthenticationResponseModel, UserModel)?> onLogin;
  final AsyncValue<bool?> onLogout;

  @override
  List<Object> get props => [onLogin, onLogout];

  @override
  bool get stringify => true;

  AuthenticationState copyWith({
    AsyncValue<(AuthenticationResponseModel, UserModel)?>? onLogin,
    AsyncValue<bool?>? onLogout,
  }) {
    return AuthenticationState(
      onLogin: onLogin ?? this.onLogin,
      onLogout: onLogout ?? this.onLogout,
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
      (failure) => state = state.copyWith(
          onLogin: AsyncError(failure.message, StackTrace.current)),
      (data) {
        return state = state.copyWith(onLogin: AsyncData(data));
      },
    );
  }

  Future<void> logout() async {
    // state = state.copyWith(onLogout: const AsyncLoading());
    final result = await repository.logout();
    result.fold(
      (failure) => state = state.copyWith(
          onLogout: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onLogout: AsyncData(data)),
    );
  }
}
