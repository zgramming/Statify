import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/survey/survey_response_create_response_model.dart';
import '../../model/survey/survey_response_model.dart';

class SurveyResponseRemoteDatasource {
  final http.Client client;
  const SurveyResponseRemoteDatasource({
    required this.client,
  });

  Future<SurveyResponseCreateResponseModel> create({
    required String surveyId,
    required String content,
    required String type,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/responses");
    final response = await client.post(
      uri,
      body: {
        'content': content,
        'type': type,
      },
    );

    if (response.statusCode == 200) {
      final body = response.body;
      final decodedData = Map<String, dynamic>.from(jsonDecode(body));
      final data = decodedData['data'];
      return SurveyResponseCreateResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to create survey response');
    }
  }

  Future<SurveyResponseModel> getResponse({
    required String machineId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/responses");
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final decodedData = Map<String, dynamic>.from(jsonDecode(body));
      final data = decodedData['data'];

      return SurveyResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to get survey response');
    }
  }
}

class SurveyResponseRepository {
  final SurveyResponseRemoteDatasource remoteDatasource;
  const SurveyResponseRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyResponseCreateResponseModel>> create({
    required String surveyId,
    required String content,
    required String type,
  }) async {
    try {
      final response = await remoteDatasource.create(
        surveyId: surveyId,
        content: content,
        type: type,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, SurveyResponseModel>> getResponse({
    required String machineId,
  }) async {
    try {
      final response = await remoteDatasource.getResponse(
        machineId: machineId,
      );
      return Right(response);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class SurveyResponseState extends Equatable {
  final AsyncValue<SurveyResponseCreateResponseModel?> onCreate;
  final AsyncValue<SurveyResponseModel?> onGetResponse;
  const SurveyResponseState({
    this.onCreate = const AsyncData(null),
    this.onGetResponse = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate, onGetResponse];

  @override
  bool get stringify => true;

  SurveyResponseState copyWith({
    AsyncValue<SurveyResponseCreateResponseModel?>? onCreate,
    AsyncValue<SurveyResponseModel?>? onGetResponse,
  }) {
    return SurveyResponseState(
      onCreate: onCreate ?? this.onCreate,
      onGetResponse: onGetResponse ?? this.onGetResponse,
    );
  }
}

class SurveyResponseNotifier extends StateNotifier<SurveyResponseState> {
  final SurveyResponseRepository repository;
  SurveyResponseNotifier({
    required this.repository,
  }) : super(const SurveyResponseState());

  Future<void> create({
    required String surveyId,
    required String content,
    required String type,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      surveyId: surveyId,
      content: content,
      type: type,
    );
    result.fold(
      (failure) => state =
          state.copyWith(onCreate: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<void> getResponse({
    required String machineId,
  }) async {
    state = state.copyWith(onGetResponse: const AsyncLoading());
    final result = await repository.getResponse(
      machineId: machineId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onGetResponse: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onGetResponse: AsyncData(data)),
    );
  }
}
