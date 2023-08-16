// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/machine/machine_create_response_model.dart';
import '../../model/machine/machine_model.dart';

class MachineRemoteDatasource {
  final http.Client client;
  const MachineRemoteDatasource({
    required this.client,
  });

  Future<List<MachineModel>> getAll(String userId) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final machines = list.map((e) => MachineModel.fromJson(e)).toList();
      return machines;
    } else {
      throw Exception('Failed to load machines');
    }
  }

  Future<MachineModel> getById({
    required String userId,
    required String machineId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines/$machineId');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineModel.fromJson(data);
      return machine;
    } else {
      throw Exception('Failed to load machine');
    }
  }

  Future<MachineModel> getByNumber({
    required String userId,
    required String machineNumber,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/machines/$machineNumber');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineModel.fromJson(data);
      return machine;
    } else {
      throw Exception('Failed to load machine');
    }
  }

  Future<MachineCreateResponseModel> create({
    required String number,
    required String license,
    required String action,
    required String smsSetting,
    required String userId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines');
    final response = await client.post(
      uri,
      body: {
        'number': number,
        'license': license,
        'action': action,
        'sms_setting': smsSetting,
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final result = MachineCreateResponseModel.fromJson(data);
      return result;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to create machine';
      throw Exception(message);
    }
  }
}

class MachineRepository {
  final MachineRemoteDatasource remoteDatasource;
  const MachineRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineModel>>> getAll(String userId) async {
    try {
      final result = await remoteDatasource.getAll(userId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineModel>> getById({
    required String userId,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        userId: userId,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineModel>> getByNumber({
    required String userId,
    required String machineNumber,
  }) async {
    try {
      final result = await remoteDatasource.getByNumber(
        userId: userId,
        machineNumber: machineNumber,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineCreateResponseModel>> create({
    required String number,
    required String license,
    required String action,
    required String smsSetting,
    required String userId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        license: license,
        action: action,
        smsSetting: smsSetting,
        userId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class MachineState extends Equatable {
  final AsyncValue<List<MachineModel>> onGetAll;
  final AsyncValue<MachineModel?> onGetById;
  final AsyncValue<MachineModel?> onGetByNumber;
  final AsyncValue<MachineCreateResponseModel?> onCreate;
  const MachineState({
    this.onGetAll = const AsyncData([]),
    this.onGetById = const AsyncData(null),
    this.onGetByNumber = const AsyncData(null),
    this.onCreate = const AsyncData(null),
  });

  @override
  List<Object> get props => [onGetAll, onGetById, onGetByNumber, onCreate];

  @override
  bool get stringify => true;

  MachineState copyWith({
    AsyncValue<List<MachineModel>>? onGetAll,
    AsyncValue<MachineModel?>? onGetById,
    AsyncValue<MachineModel?>? onGetByNumber,
    AsyncValue<MachineCreateResponseModel?>? onCreate,
  }) {
    return MachineState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onCreate: onCreate ?? this.onCreate,
    );
  }
}

class MachineNotifier extends StateNotifier<MachineState> {
  final MachineRepository repository;
  MachineNotifier({
    required this.repository,
  }) : super(const MachineState());

  Future<void> getAll(String userId) async {
    state = state.copyWith(onGetAll: const AsyncLoading());
    final result = await repository.getAll(userId);
    result.fold(
      (failure) => state =
          state.copyWith(onGetAll: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncData(data)),
    );
  }

  Future<void> getById({
    required String userId,
    required String machineId,
  }) async {
    state = state.copyWith(onGetById: const AsyncLoading());
    final result = await repository.getById(
      userId: userId,
      machineId: machineId,
    );
    result.fold(
      (failure) => state =
          state.copyWith(onGetById: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onGetById: AsyncData(data)),
    );
  }

  Future<void> getByNumber({
    required String userId,
    required String machineNumber,
  }) async {
    state = state.copyWith(onGetByNumber: const AsyncLoading());
    final result = await repository.getByNumber(
      userId: userId,
      machineNumber: machineNumber,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onGetByNumber: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onGetByNumber: AsyncData(data)),
    );
  }

  Future<void> create({
    required String number,
    required String license,
    required String action,
    required String smsSetting,
    required String userId,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      number: number,
      license: license,
      action: action,
      smsSetting: smsSetting,
      userId: userId,
    );
    result.fold(
      (failure) => state =
          state.copyWith(onCreate: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }
}
