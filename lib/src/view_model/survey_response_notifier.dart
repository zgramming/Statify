import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/survey/survey_response_create_response_model.dart';
import '../model/model/survey/survey_response_model.dart';
import '../model/repository/survey_response_repository.dart';

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
    required String key,
    required String type,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      surveyId: surveyId,
      key: key,
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
