import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/form/form_survey_response_create_model.dart';
import '../model/model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../model/model/survey_response/survey_response_create_response_model.dart';
import '../model/model/survey_response/survey_response_fail_model.dart';
import '../model/model/survey_response/survey_response_sent_model.dart';
import '../model/repository/survey_response_repository.dart';
import '../utils/enum.dart';

class SurveyResponseState extends Equatable {
  final AsyncValue<SurveyResponseCreateResponseModel?> onCreate;
  final AsyncValue<SurveyResponseByMachineAndTypeModel?> onGetPendingResponse;
  final AsyncValue<SurveyResponseFailModel?> onFail;
  final AsyncValue<SurveyResponseSentModel?> onSent;
  final Stream<int>? onListenPendingResponse;

  const SurveyResponseState({
    this.onCreate = const AsyncData(null),
    this.onGetPendingResponse = const AsyncData(null),
    this.onFail = const AsyncData(null),
    this.onSent = const AsyncData(null),
    this.onListenPendingResponse,
  });

  @override
  List<Object?> get props {
    return [
      onCreate,
      onGetPendingResponse,
      onFail,
      onSent,
      onListenPendingResponse,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseState copyWith({
    AsyncValue<SurveyResponseCreateResponseModel?>? onCreate,
    AsyncValue<SurveyResponseByMachineAndTypeModel?>? onGetPendingResponse,
    AsyncValue<SurveyResponseFailModel?>? onFail,
    AsyncValue<SurveyResponseSentModel?>? onSent,
    Stream<int>? onListenPendingResponse,
  }) {
    return SurveyResponseState(
      onCreate: onCreate ?? this.onCreate,
      onGetPendingResponse: onGetPendingResponse ?? this.onGetPendingResponse,
      onFail: onFail ?? this.onFail,
      onSent: onSent ?? this.onSent,
      onListenPendingResponse:
          onListenPendingResponse ?? this.onListenPendingResponse,
    );
  }
}

class SurveyResponseNotifier extends StateNotifier<SurveyResponseState> {
  final SurveyResponseRepository repository;

  SurveyResponseNotifier({
    required this.repository,
  }) : super(const SurveyResponseState());

  Future<void> getPendingResponse(
      String machineId, MachineResponsePlatformEnum platform) async {
    state = state.copyWith(onGetPendingResponse: const AsyncLoading());
    final result = await repository.getPendingResponse(machineId, platform);
    result.fold(
      (failure) => state = state.copyWith(
          onGetPendingResponse:
              AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetPendingResponse: AsyncData(data)),
    );
  }

  Future<void> create(FormSurveyResponseCreateModel form) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(form);
    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<SurveyResponseState> sent(String surveyResponseId) async {
    state = state.copyWith(onSent: const AsyncLoading());
    final result = await repository.sent(surveyResponseId);
    final fold = result.fold(
      (failure) => state = state.copyWith(
          onSent: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onSent: AsyncData(data)),
    );

    return fold;
  }

  Future<SurveyResponseState> fail(String surveyResponseId) async {
    state = state.copyWith(onFail: const AsyncLoading());
    final result = await repository.fail(surveyResponseId);
    final fold = result.fold(
      (failure) => state = state.copyWith(
          onFail: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onFail: AsyncData(data)),
    );
    return fold;
  }

  Stream<String?> listenPendingResponse({
    required String machineId,
    required int simSlot,
  }) {
    final result = repository.listenPendingResponse(
      machineId: machineId,
      simSlot: simSlot,
    );
    final fold = result.getOrElse(() => Stream.value(null));

    return fold;
  }
}
