import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/machine/machine_response_setting_create_response_model.dart';
import '../../model/machine/machine_response_setting_model.dart';

class MachineResponseSettingRemoteDatasource {
  final http.Client client;
  const MachineResponseSettingRemoteDatasource({
    required this.client,
  });

  Future<List<MachineResponseSettingModel>> getAll(String idMachine) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$idMachine/response-settings");
    final response = await client.get(uri);

    final body = response.body;
    final decode = Map.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decode['data'] as List;

      final result =
          list.map((e) => MachineResponseSettingModel.fromJson(e)).toList();

      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MachineResponseSettingCreateResponseModel> create({
    required String key,
    required String value,
    required String type,
    required String idMachine,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$idMachine/response-settings");

    final response = await client.post(
      uri,
      body: {
        'key': key,
        'value': value,
        'type': type,
      },
    );

    final body = response.body;
    final decode = Map.from(jsonDecode(body));
    log('getAll $decode');

    if (response.statusCode == 200) {
      final data = decode['data'];
      final result = MachineResponseSettingCreateResponseModel.fromJson(data);
      return result;
    } else {
      final message = decode.containsKey('message')
          ? decode['message']
          : 'Failed to load data';
      throw Exception(message);
    }
  }
}

class MachineResponseSettingRepository {
  final MachineResponseSettingRemoteDatasource remoteDatasource;
  const MachineResponseSettingRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineResponseSettingModel>>> getAll(
      String idMachine) async {
    try {
      final result = await remoteDatasource.getAll(idMachine);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineResponseSettingCreateResponseModel>> create({
    required String key,
    required String value,
    required String type,
    required String idMachine,
  }) async {
    try {
      final result = await remoteDatasource.create(
        key: key,
        value: value,
        type: type,
        idMachine: idMachine,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class MachineResponseSettingState extends Equatable {
  final AsyncValue<List<MachineResponseSettingModel>> onGetAll;
  final AsyncValue<MachineResponseSettingCreateResponseModel?> onCreate;

  const MachineResponseSettingState({
    this.onGetAll = const AsyncData([]),
    this.onCreate = const AsyncData(null),
  });

  @override
  List<Object> get props => [onGetAll, onCreate];

  @override
  bool get stringify => true;

  MachineResponseSettingState copyWith({
    AsyncValue<List<MachineResponseSettingModel>>? onGetAll,
    AsyncValue<MachineResponseSettingCreateResponseModel>? onCreate,
  }) {
    return MachineResponseSettingState(
      onGetAll: onGetAll ?? this.onGetAll,
      onCreate: onCreate ?? this.onCreate,
    );
  }
}

class MachineResponseSettingNotifier
    extends StateNotifier<MachineResponseSettingState> {
  final MachineResponseSettingRepository repository;

  MachineResponseSettingNotifier({
    required this.repository,
  }) : super(const MachineResponseSettingState());

  Future<void> getAll(String idMachine) async {
    state = state.copyWith(onGetAll: const AsyncLoading());
    final result = await repository.getAll(idMachine);

    result.fold(
      (failure) => state =
          state.copyWith(onGetAll: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncData(data)),
    );
  }

  Future<void> create({
    required String key,
    required String value,
    required String type,
    required String idMachine,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      key: key,
      value: value,
      type: type,
      idMachine: idMachine,
    );

    result.fold(
      (failure) => state =
          state.copyWith(onCreate: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }
}
