import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/survey/survey_by_machine_and_number_model.dart';
import '../model/model/survey/survey_create_response_model.dart';
import '../model/model/survey/survey_unlock_response_model.dart';
import '../model/repository/survey_repository.dart';

class SurveyState extends Equatable {
  final AsyncValue<SurveyCreateResponseModel?> onCreate;
  final AsyncValue<SurveyByMachineAndNumberModel?> onGetByMachineAndNumber;
  final AsyncValue<SurveyUnlockResponseModel?> onUnlock;

  const SurveyState({
    this.onCreate = const AsyncData(null),
    this.onGetByMachineAndNumber = const AsyncData(null),
    this.onUnlock = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate, onGetByMachineAndNumber, onUnlock];

  @override
  bool get stringify => true;

  SurveyState copyWith({
    AsyncValue<SurveyCreateResponseModel?>? onCreate,
    AsyncValue<SurveyByMachineAndNumberModel?>? onGetByMachineAndNumber,
    AsyncValue<SurveyUnlockResponseModel?>? onUnlock,
  }) {
    return SurveyState(
      onCreate: onCreate ?? this.onCreate,
      onGetByMachineAndNumber:
          onGetByMachineAndNumber ?? this.onGetByMachineAndNumber,
      onUnlock: onUnlock ?? this.onUnlock,
    );
  }
}

class SurveyNotifier extends StateNotifier<SurveyState> {
  final SurveyRepository repository;
  SurveyNotifier({
    required this.repository,
  }) : super(const SurveyState());

  Future<void> getByMachineAndNumber({
    required String machineId,
    required String number,
  }) async {
    state = state.copyWith(onGetByMachineAndNumber: const AsyncLoading());
    final result = await repository.getByMachineAndNumber(
      machineId: machineId,
      number: number,
    );

    result.fold(
      (failure) => state = state.copyWith(
          onGetByMachineAndNumber:
              AsyncError(failure.message, StackTrace.current)),
      (data) =>
          state = state.copyWith(onGetByMachineAndNumber: AsyncData(data)),
    );
  }

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
      (failure) => state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncData(data)),
    );
  }

  Future<void> unlock({
    required String surveyId,
    required String key,
    required String platform,
  }) async {
    state = state.copyWith(onUnlock: const AsyncLoading());
    final result = await repository.unlock(
      surveyId: surveyId,
      key: key,
      platform: platform,
    );

    result.fold(
      (failure) => state = state.copyWith(
          onUnlock: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onUnlock: AsyncData(data)),
    );
  }
}
