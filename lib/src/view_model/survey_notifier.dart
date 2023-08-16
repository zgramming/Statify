import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/survey/survey_create_response_model.dart';
import '../model/repository/survey_repository.dart';

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
