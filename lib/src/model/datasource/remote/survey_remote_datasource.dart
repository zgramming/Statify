// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/survey/survey.model.dart';

class FormSurveyCreateOrUpdateModel extends Equatable {
  final String name;
  final String action;
  final String? template;

  const FormSurveyCreateOrUpdateModel({
    required this.name,
    required this.action,
    required this.template,
  });

  @override
  List<Object?> get props => [name, action, template];

  @override
  bool get stringify => true;
}

class SurveyRemoteDatasource {
  final http.Client client;
  const SurveyRemoteDatasource({
    required this.client,
  });

  Future<List<SurveyModel>> getAll({
    required String machineId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'] as List<dynamic>;
      final result = List<SurveyModel>.from(
        data.map((x) => SurveyModel.fromJson(x)),
      );
      log("getAll: $result");

      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel?> getById({
    required String machineId,
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (data == null) return null;

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> getByNumber({
    required String number,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/surveys/$number",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> create({
    required String machineId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys",
    );
    final response = await client.post(
      uri,
      body: {
        'name': form.name,
        'action': form.action,
        'template': form.template,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> update({
    required String machineId,
    required String surveyId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId",
    );
    final response = await client.patch(
      uri,
      body: {
        'name': form.name,
        'action': form.action,
        'template': form.template,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to update survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> active({
    required String machineId,
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId/active",
    );
    final response = await client.patch(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to activated survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> delete({
    required String machineId,
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId",
    );
    final response = await client.delete(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to delete survey';
      throw Exception(message);
    }
  }
}

class SurveyRepository {
  final SurveyRemoteDatasource remoteDatasource;
  const SurveyRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, List<SurveyModel>>> getAll({
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.getAll(
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel?>> getById({
    required String machineId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.getById(
        machineId: machineId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> getByNumber({
    required String number,
  }) async {
    try {
      final result = await remoteDatasource.getByNumber(
        number: number,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> create({
    required String machineId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    try {
      final result = await remoteDatasource.create(
        machineId: machineId,
        form: form,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> update({
    required String machineId,
    required String surveyId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    try {
      final result = await remoteDatasource.update(
        machineId: machineId,
        surveyId: surveyId,
        form: form,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> active({
    required String machineId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.active(
        machineId: machineId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyModel>> delete({
    required String machineId,
    required String surveyId,
  }) async {
    try {
      final result = await remoteDatasource.delete(
        machineId: machineId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class SurveyState extends Equatable {
  final List<SurveyModel> items;
  final AsyncValue<List<SurveyModel>?> onGetAll;
  final AsyncValue<SurveyModel?> onGetById;
  final AsyncValue<SurveyModel?> onGetByNumber;
  final AsyncValue<SurveyModel?> onCreate;
  final AsyncValue<SurveyModel?> onUpdate;
  final AsyncValue<SurveyModel?> onActive;
  final AsyncValue<SurveyModel?> onDelete;

  const SurveyState({
    this.items = const [],
    this.onGetAll = const AsyncData(null),
    this.onGetById = const AsyncData(null),
    this.onGetByNumber = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onActive = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetAll,
      onGetById,
      onGetByNumber,
      onCreate,
      onUpdate,
      onActive,
      onDelete,
    ];
  }

  @override
  bool get stringify => true;

  SurveyState copyWith({
    List<SurveyModel>? items,
    AsyncValue<List<SurveyModel>?>? onGetAll,
    AsyncValue<SurveyModel?>? onGetById,
    AsyncValue<SurveyModel?>? onGetByNumber,
    AsyncValue<SurveyModel?>? onCreate,
    AsyncValue<SurveyModel?>? onUpdate,
    AsyncValue<SurveyModel?>? onActive,
    AsyncValue<SurveyModel?>? onDelete,
  }) {
    return SurveyState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onActive: onActive ?? this.onActive,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class SurveyNotifier extends StateNotifier<SurveyState> {
  final SurveyRepository repository;
  final String machineId;
  SurveyNotifier({
    required this.repository,
    required this.machineId,
  }) : super(const SurveyState()) {
    getAll();
  }

  Future<SurveyState> getAll() async {
    state = state.copyWith(
      onGetAll: const AsyncLoading(),
    );
    final result = await repository.getAll(
      machineId: machineId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetAll: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          items: data,
          onGetAll: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> getById({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onGetById: const AsyncLoading(),
    );
    final result = await repository.getById(
      machineId: machineId,
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetById: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onGetById: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> getByNumber({
    required String number,
  }) async {
    state = state.copyWith(
      onGetByNumber: const AsyncLoading(),
    );
    final result = await repository.getByNumber(
      number: number,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetByNumber: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onGetByNumber: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> create({
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    state = state.copyWith(
      onCreate: const AsyncLoading(),
    );
    final result = await repository.create(
      machineId: machineId,
      form: form,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onCreate: AsyncData(data),
          items: [...state.items, data],
        );
      },
    );
  }

  Future<SurveyState> update({
    required String surveyId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    state = state.copyWith(
      onUpdate: const AsyncLoading(),
    );
    final result = await repository.update(
      machineId: machineId,
      surveyId: surveyId,
      form: form,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onUpdate: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onUpdate: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item,
          ],
        );
      },
    );
  }

  Future<SurveyState> active({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onActive: const AsyncLoading(),
    );
    final result = await repository.active(
      machineId: machineId,
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onActive: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onActive: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item,
          ],
        );
      },
    );
  }

  Future<SurveyState> delete({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onDelete: const AsyncLoading(),
    );
    final result = await repository.delete(
      machineId: machineId,
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onDelete: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        final result = state.items.where((item) => item.id != data.id).toList();
        return state = state.copyWith(
          onDelete: AsyncData(data),
          items: result,
        );
      },
    );
  }
}
