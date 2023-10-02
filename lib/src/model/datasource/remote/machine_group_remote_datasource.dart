import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/helper/form/form_machine_group_create_update.model.dart';
import '../../model/machine_group/machine_group.model.dart';

class MachineGroupRemoteDatasource {
  final http.Client client;
  const MachineGroupRemoteDatasource({
    required this.client,
  });

  Future<List<MachineGroupModel>> getAll(String userId) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machine-groups');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;

      final machines = list.map((e) {
        final result = MachineGroupModel.fromJson(e);
        return result;
      }).toList();

      return machines;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel?> getById({
    required String userId,
    required String machineGroupId,
  }) async {
    final uri =
        Uri.parse('$kBaseApiUrl/users/$userId/machine-groups/$machineGroupId');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (data == null) {
      return null;
    }

    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel> create(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    final uri = Uri.parse("$kBaseApiUrl/users/${form.userId}/machine-groups");

    final bodyForm = jsonEncode({
      'name': form.name,
      'machines': form.machineIds,
    });
    final response = await client.post(
      uri,
      body: bodyForm,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];
    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to create machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel> update(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    final uri = Uri.parse(
        "$kBaseApiUrl/users/${form.userId}/machine-groups/${form.machineGroupId}");

    final bodyForm = jsonEncode(
      {
        'name': form.name,
        'machines': form.machineIds,
      },
    );

    final response = await client.patch(
      uri,
      body: bodyForm,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];
    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel> delete({
    required String userId,
    required String machineGroupId,
  }) async {
    final uri =
        Uri.parse('$kBaseApiUrl/users/$userId/machine-groups/$machineGroupId');
    final response = await client.delete(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (data == null) {
      throw Exception('Failed to delete machine');
    }

    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to delete machine';
      throw Exception(message);
    }
  }
}

class MachineGroupRepository {
  final MachineGroupRemoteDatasource remoteDatasource;
  const MachineGroupRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<MachineGroupModel>>> getAll(String userId) async {
    try {
      final result = await remoteDatasource.getAll(userId);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel?>> getById({
    required String userId,
    required String machineGroupId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        userId: userId,
        machineGroupId: machineGroupId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel>> create(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    try {
      final result = await remoteDatasource.create(form);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel>> update(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    try {
      final result = await remoteDatasource.update(form);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, MachineGroupModel>> delete({
    required String userId,
    required String machineGroupId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        userId: userId,
        machineGroupId: machineGroupId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class MachineGroupState extends Equatable {
  final List<MachineGroupModel> items;
  final AsyncValue<List<MachineGroupModel>?> onGetAll;
  final AsyncValue<MachineGroupModel?> onGetById;
  final AsyncValue<MachineGroupModel?> onCreate;
  final AsyncValue<MachineGroupModel?> onUpdate;
  final AsyncValue<MachineGroupModel?> onDelete;
  const MachineGroupState({
    this.items = const [],
    this.onGetAll = const AsyncData(null),
    this.onGetById = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetAll,
      onGetById,
      onCreate,
      onUpdate,
      onDelete,
    ];
  }

  @override
  bool get stringify => true;

  MachineGroupState copyWith({
    List<MachineGroupModel>? items,
    AsyncValue<List<MachineGroupModel>?>? onGetAll,
    AsyncValue<MachineGroupModel?>? onGetById,
    AsyncValue<MachineGroupModel?>? onCreate,
    AsyncValue<MachineGroupModel?>? onUpdate,
    AsyncValue<MachineGroupModel?>? onDelete,
  }) {
    return MachineGroupState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class MachineGroupNotifier extends StateNotifier<MachineGroupState> {
  final MachineGroupRepository repository;
  final String userId;
  MachineGroupNotifier({
    required this.repository,
    required this.userId,
  }) : super(const MachineGroupState());

  Future<MachineGroupState> getAll() async {
    final result = await repository.getAll(userId);
    return result.fold(
      (failure) => state = state.copyWith(
        onGetAll: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(
        onGetAll: AsyncData(data),
        items: [
          ...data,
        ],
      ),
    );
  }

  Future<MachineGroupState> getById({
    required String machineGroupId,
  }) async {
    state = state.copyWith(onGetById: const AsyncLoading());
    final result = await repository.getById(
      userId: userId,
      machineGroupId: machineGroupId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onGetById: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(
        onGetById: AsyncData(data),
      ),
    );
  }

  Future<MachineGroupState> create(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(form);
    return result.fold(
      (failure) => state = state.copyWith(
        onCreate: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(
        onCreate: AsyncData(data),
        items: [...state.items, data],
      ),
    );
  }

  Future<MachineGroupState> update(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    state = state.copyWith(onUpdate: const AsyncLoading());
    final result = await repository.update(form);
    return result.fold(
      (failure) => state = state.copyWith(
        onUpdate: AsyncError(failure.message, StackTrace.current),
      ),
      (data) {
        return state = state.copyWith(
          onUpdate: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item
          ],
        );
      },
    );
  }

  Future<MachineGroupState> delete({
    required String machineGroupId,
  }) async {
    state = state.copyWith(onDelete: const AsyncLoading());
    final result = await repository.delete(
      userId: userId,
      machineGroupId: machineGroupId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onDelete: AsyncError(failure.message, StackTrace.current),
      ),
      (data) {
        return state = state.copyWith(
          onDelete: AsyncData(data),
          items: state.items.where((item) => item.id != data.id).toList(),
        );
      },
    );
  }
}
