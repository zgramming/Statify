import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../../utils/failure.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../model/helper/form/form_machine_create_update_model.dart';
import '../../model/helper/form/form_user_update_model.dart';
import '../../model/user/user_model.dart';
import '../../model/user/user_update.model.dart';
import 'machine_remote_datasource.dart';

class UserRemoteDatasource {
  const UserRemoteDatasource({
    required this.client,
    required this.machineRemoteDatasource,
  });

  final http.Client client;
  final MachineRemoteDatasource machineRemoteDatasource;

  Future<UserModel?> getById(String id) async {
    final uri = Uri.parse("$kBaseApiUrl/users/$id");
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];
    if (data == null) {
      return null;
    }
    if (response.statusCode == 200) {
      final user = UserModel.fromJson(data);
      return user;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load user';
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

  Future<(UserUpdateResponseModel, UserModel)> update({
    required String userId,
    required FormUserUpdateModel form,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/users/$userId");

    final response = await client.patch(
      uri,
      body: {
        'username': form.username,
        'name': form.name,
        'country_code': form.countryCode,
        'sim_1': form.sim1,
        'sim_2': form.sim2,
      },
    );
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final user = await getById(userId);
      if (user == null) {
        throw Exception(
            'Failed to update user, when try to get user by id after update');
      }

      final data = decoded['data'];
      final currentToken = await FlutterSecureStorageUtils.getTokenAuth();
      final result = UserUpdateResponseModel.fromJson(data);

      await _updateMachineDependSIM(
        machineIds: form.machineIds,
        machineSimSlot: form.machineSimSlot,
        userId: userId,
        sim1Number: result.sim1 ?? "",
        sim2Number: result.sim2 ?? "",
      );

      return (
        result,
        user.copyWith(
          token: currentToken,
        )
      );
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update user';
      throw Exception(message);
    }
  }

  Future<void> _updateMachineDependSIM({
    required List<String> machineIds,
    required WhatSIMHasBeenChanged machineSimSlot,
    required String userId,
    required String sim1Number,
    required String sim2Number,
  }) async {
    switch (machineSimSlot) {
      case WhatSIMHasBeenChanged.sim1:
      case WhatSIMHasBeenChanged.sim2:
        final machineId = machineIds.first;
        final machine = await machineRemoteDatasource.getById(
          userId: userId,
          machineId: machineId,
        );

        await machineRemoteDatasource.update(
          form: FormMachineCreateUpdateModel(
            name: "${machine?.name}",
            number: machineSimSlot == WhatSIMHasBeenChanged.sim1
                ? sim1Number
                : sim2Number,
            serialNumber: "${machine?.serialNumber}",
            license: "${machine?.license}",
          ),
          machineId: machineId,
          userId: userId,
        );

        break;

      case WhatSIMHasBeenChanged.both:
        int index = 0;

        for (final machineId in machineIds) {
          final machine = await machineRemoteDatasource.getById(
            userId: userId,
            machineId: machineId,
          );

          await machineRemoteDatasource.update(
            form: FormMachineCreateUpdateModel(
              name: "${machine?.name}",
              number: index == 0 ? sim1Number : sim2Number,
              serialNumber: "${machine?.serialNumber}",
              license: "${machine?.license}",
            ),
            machineId: machineId,
            userId: userId,
          );
          index++;
        }
        break;

      default:
    }
  }
}

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

class UserState extends Equatable {
  final UserModel? user;
  final AsyncValue<UserModel?> onGetById;
  final AsyncValue<(UserUpdateResponseModel, UserModel)?> onUpdate;
  const UserState({
    this.user,
    this.onGetById = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
  });

  @override
  List<Object?> get props => [user, onGetById, onUpdate];

  @override
  bool get stringify => true;

  UserState copyWith({
    UserModel? user,
    AsyncValue<UserModel?>? onGetById,
    AsyncValue<(UserUpdateResponseModel, UserModel)?>? onUpdate,
  }) {
    return UserState(
      user: user ?? this.user,
      onGetById: onGetById ?? this.onGetById,
      onUpdate: onUpdate ?? this.onUpdate,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository repository;
  UserNotifier({
    required this.repository,
  }) : super(const UserState());

  Future<UserState> getById(String id) async {
    state = state.copyWith(
      onGetById: const AsyncLoading(),
    );
    final result = await repository.getById(id);
    return result.fold(
      (failure) => state = state.copyWith(
        onGetById: AsyncError(
          failure.message,
          StackTrace.current,
        ),
        user: null,
      ),
      (user) => state = state.copyWith(
        user: user,
        onGetById: AsyncData(user),
      ),
    );
  }

  Future<UserState> update({
    required String id,
    required FormUserUpdateModel form,
  }) async {
    state = state.copyWith(
      onUpdate: const AsyncLoading(),
    );
    final result = await repository.update(
      userId: id,
      form: form,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onUpdate: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (user) => state = state.copyWith(
        onUpdate: AsyncData(user),
        user: state.user?.copyWith(
          username: form.username,
          name: form.name,
          countryCode: form.countryCode,
          sim1: form.sim1,
          sim2: form.sim2,
        ),
      ),
    );
  }

  void setUser(UserModel user) {
    final currentToken = state.user?.token;
    state = state.copyWith(
      user: user.copyWith(
        token: currentToken,
      ),
    );
  }
}
