// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/failure.dart';
import '../../model/survey/survey_create_response_model.dart';

class SurveyRemoteDatasource {
  final http.Client client;
  const SurveyRemoteDatasource({
    required this.client,
  });

  Future<SurveyCreateResponseModel> create({
    required String number,
    required String machineId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/surveys");
    final response = await client.post(
      uri,
      body: {
        'number': number,
      },
    );

    if (response.statusCode == 200) {
      final body = response.body;
      final decodedData = Map<String, dynamic>.from(jsonDecode(body));
      final data = decodedData['data'];

      final result = SurveyCreateResponseModel.fromJson(data);
      return result;
    } else {
      throw Exception('Failed to create machine');
    }
  }
}

class SurveyRepository {
  final SurveyRemoteDatasource remoteDatasource;
  const SurveyRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, SurveyCreateResponseModel>> create({
    required String number,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        machineId: machineId,
      );
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class SurveyState extends Equatable {
  final AsyncValue<SurveyCreateResponseModel?> onCreate;
  const SurveyState({
    this.onCreate = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate];

  @override
  bool get stringify => true;

  SurveyState copyWith({
    AsyncValue<SurveyCreateResponseModel?>? onCreate,
  }) {
    return SurveyState(
      onCreate: onCreate ?? this.onCreate,
    );
  }
}

class SurveyNotifier extends StateNotifier<SurveyState> {
  final SurveyRepository repository;
  SurveyNotifier({
    required this.repository,
  }) : super(const SurveyState());

  Future<void> create({
    required String number,
    required String machineId,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      number: number,
      machineId: machineId,
    );

    result.fold(
      (failure) => state =
          state.copyWith(onCreate: AsyncError(failure, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }
}
