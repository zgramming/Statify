import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../model/model/survey_response/survey_response_create_response_model.dart';
import '../model/model/survey_response/survey_response_fail_model.dart';
import '../model/model/survey_response/survey_response_sent_model.dart';
import '../model/repository/survey_response_repository.dart';

class SurveyResponseState extends Equatable {
  final AsyncValue<SurveyResponseCreateResponseModel?> onCreate;
  final AsyncValue<SurveyResponseByMachineAndTypeModel?> onGetByMachineAndType;
  final AsyncValue<SurveyResponseFailModel?> onFail;
  final AsyncValue<SurveyResponseSentModel?> onSent;

  const SurveyResponseState({
    this.onCreate = const AsyncData(null),
    this.onGetByMachineAndType = const AsyncData(null),
    this.onFail = const AsyncData(null),
    this.onSent = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate, onGetByMachineAndType, onFail, onSent];

  @override
  bool get stringify => true;

  SurveyResponseState copyWith({
    AsyncValue<SurveyResponseCreateResponseModel?>? onCreate,
    AsyncValue<SurveyResponseByMachineAndTypeModel?>? onGetByMachineAndType,
    AsyncValue<SurveyResponseFailModel?>? onFail,
    AsyncValue<SurveyResponseSentModel?>? onSent,
  }) {
    return SurveyResponseState(
      onCreate: onCreate ?? this.onCreate,
      onGetByMachineAndType:
          onGetByMachineAndType ?? this.onGetByMachineAndType,
      onFail: onFail ?? this.onFail,
      onSent: onSent ?? this.onSent,
    );
  }
}

class SurveyResponseNotifier extends StateNotifier<SurveyResponseState> {
  final SurveyResponseRepository repository;
  SurveyResponseNotifier({
    required this.repository,
  }) : super(const SurveyResponseState());

  Future<void> getByMachineAndType(String machineId) async {
    state = state.copyWith(onGetByMachineAndType: const AsyncLoading());
    final result = await repository.getByMachineAndType(machineId);
    result.fold(
      (failure) => state = state.copyWith(
          onGetByMachineAndType:
              AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetByMachineAndType: AsyncData(data)),
    );
  }

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
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<void> sent(String surveyResponseId) async {
    state = state.copyWith(onSent: const AsyncLoading());
    final result = await repository.sent(surveyResponseId);
    result.fold(
      (failure) => state = state.copyWith(
          onSent: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onSent: AsyncData(data)),
    );
  }

  Future<void> fail(String surveyResponseId) async {
    state = state.copyWith(onFail: const AsyncLoading());
    final result = await repository.fail(surveyResponseId);
    result.fold(
      (failure) => state = state.copyWith(
          onFail: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onFail: AsyncData(data)),
    );
  }
}
