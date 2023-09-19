import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/survey_responden/survey_responden_create.model.dart';
import '../model/model/survey_responden/survey_responden_unlock.model.dart';
import '../model/repository/survey_responden.repository.dart';

class SurveyRespondenState extends Equatable {
  final AsyncValue<SurveyRespondenCreateModel?> onCreate;
  final AsyncValue<SurveyRespondenUnlockModel?> onUnlock;

  const SurveyRespondenState({
    this.onCreate = const AsyncData(null),
    this.onUnlock = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate, onUnlock];

  @override
  bool get stringify => true;

  SurveyRespondenState copyWith({
    AsyncValue<SurveyRespondenCreateModel?>? onCreate,
    AsyncValue<SurveyRespondenUnlockModel?>? onUnlock,
  }) {
    return SurveyRespondenState(
      onCreate: onCreate ?? this.onCreate,
      onUnlock: onUnlock ?? this.onUnlock,
    );
  }
}

class SurveyRespondenNotifier extends StateNotifier<SurveyRespondenState> {
  final SurveyRespondenRepository repository;
  SurveyRespondenNotifier({
    required this.repository,
  }) : super(const SurveyRespondenState());

  Future<void> create({
    required String number,
    required String machineId,
    required String? key,
  }) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(
      number: number,
      machineId: machineId,
      key: key,
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
