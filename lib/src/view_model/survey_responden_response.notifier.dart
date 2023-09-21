import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_survey_responden_response_create_model.dart';
import '../model/model/survey_responden_response/survey_responden_response_create_response_model.dart';
import '../model/model/survey_responden_response/survey_responden_response_fail_model.dart';
import '../model/model/survey_responden_response/survey_responden_response_sent_model.dart';
import '../model/repository/survey_responden_response.repository.dart';

class SurveyRespondenResponseState extends Equatable {
  final AsyncValue<SurveyRespondenResponseCreateResponseModel?> onCreate;

  final AsyncValue<SurveyRespondenResponseFailModel?> onFail;
  final AsyncValue<SurveyRespondenResponseSentModel?> onSent;
  final Stream<int>? onListenPendingResponse;

  const SurveyRespondenResponseState({
    this.onCreate = const AsyncData(null),
    this.onFail = const AsyncData(null),
    this.onSent = const AsyncData(null),
    this.onListenPendingResponse = const Stream.empty(),
  });

  @override
  List<Object?> get props =>
      [onCreate, onFail, onSent, onListenPendingResponse];

  @override
  bool get stringify => true;

  SurveyRespondenResponseState copyWith({
    AsyncValue<SurveyRespondenResponseCreateResponseModel?>? onCreate,
    AsyncValue<SurveyRespondenResponseFailModel?>? onFail,
    AsyncValue<SurveyRespondenResponseSentModel?>? onSent,
    Stream<int>? onListenPendingResponse,
  }) {
    return SurveyRespondenResponseState(
      onCreate: onCreate ?? this.onCreate,
      onFail: onFail ?? this.onFail,
      onSent: onSent ?? this.onSent,
      onListenPendingResponse:
          onListenPendingResponse ?? this.onListenPendingResponse,
    );
  }
}

class SurveyRespondenResponseNotifier
    extends StateNotifier<SurveyRespondenResponseState> {
  final SurveyRespondenResponseRepository repository;
  final String surveyRespondenId;

  SurveyRespondenResponseNotifier({
    required this.repository,
    required this.surveyRespondenId,
  }) : super(const SurveyRespondenResponseState());

  Future<void> create(FormSurveyRespondenResponseCreateModel form) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(form: form);
    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<SurveyRespondenResponseState> sent({
    required String surveyRespondenResponseId,
  }) async {
    state = state.copyWith(onSent: const AsyncLoading());
    final result = await repository.sent(
      surveyRespondenId: surveyRespondenId,
      surveyRespondenResponseId: surveyRespondenResponseId,
    );
    final fold = result.fold(
      (failure) => state = state.copyWith(
          onSent: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onSent: AsyncData(data)),
    );

    return fold;
  }

  Future<SurveyRespondenResponseState> fail({
    required String surveyRespondenResponseId,
  }) async {
    state = state.copyWith(onFail: const AsyncLoading());
    final result = await repository.fail(
      surveyRespondenId: surveyRespondenId,
      surveyRespondenResponseId: surveyRespondenResponseId,
    );
    final fold = result.fold(
      (failure) => state = state.copyWith(
          onFail: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onFail: AsyncData(data)),
    );
    return fold;
  }
}
