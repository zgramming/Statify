// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/survey_responden/survey_responden_by_number.model.dart';
import '../model/model/survey_responden/survey_responden_create.model.dart';
import '../model/model/survey_responden/survey_responden_unlock.model.dart';
import '../model/repository/survey_responden.repository.dart';

class SurveyState extends Equatable {
  final AsyncValue<SurveyRespondenCreateModel?> onCreate;
  final AsyncValue<SurveyRespondenByNumberModel?> onGetByNumber;
  final AsyncValue<SurveyRespondenUnlockModel?> onUnlock;

  const SurveyState({
    this.onCreate = const AsyncData(null),
    this.onGetByNumber = const AsyncData(null),
    this.onUnlock = const AsyncData(null),
  });

  @override
  List<Object> get props => [onCreate, onGetByNumber, onUnlock];

  @override
  bool get stringify => true;

  SurveyState copyWith({
    AsyncValue<SurveyRespondenCreateModel?>? onCreate,
    AsyncValue<SurveyRespondenByNumberModel?>? onGetByNumber,
    AsyncValue<SurveyRespondenUnlockModel?>? onUnlock,
  }) {
    return SurveyState(
      onCreate: onCreate ?? this.onCreate,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onUnlock: onUnlock ?? this.onUnlock,
    );
  }
}

class SurveyNotifier extends StateNotifier<SurveyState> {
  final SurveyRepository repository;
  SurveyNotifier({
    required this.repository,
  }) : super(const SurveyState());

  Future<void> getByNumber({
    required String machineId,
    required String number,
  }) async {
    state = state.copyWith(onGetByNumber: const AsyncLoading());
    final result = await repository.getByNumber(
      machineId: machineId,
      number: number,
    );

    result.fold(
      (failure) => state = state.copyWith(
          onGetByNumber: AsyncError(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetByNumber: AsyncData(data)),
    );
  }

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
