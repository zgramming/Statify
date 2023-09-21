import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_machine_response_create_update_model.dart';
import '../model/model/survey_response/survey_response_create_response_model.dart';
import '../model/model/survey_response/survey_response_model.dart';
import '../model/repository/survey_response_repository.dart';

class SurveyResponseState extends Equatable {
  final AsyncValue<List<SurveyResponseModel>> onGetAll;
  final AsyncValue<SurveyResponseModel?> onGetById;
  final AsyncValue<SurveyResponseCreateModel?> onCreate;
  final AsyncValue<SurveyResponseModel?> onUpdate;
  final AsyncValue<SurveyResponseModel?> onDelete;
  const SurveyResponseState({
    this.onGetAll = const AsyncValue.data([]),
    this.onGetById = const AsyncValue.data(null),
    this.onCreate = const AsyncValue.data(null),
    this.onDelete = const AsyncValue.data(null),
    this.onUpdate = const AsyncValue.data(null),
  });

  @override
  List<Object> get props {
    return [
      onGetAll,
      onGetById,
      onCreate,
      onUpdate,
      onDelete,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseState copyWith({
    AsyncValue<List<SurveyResponseModel>>? onGetAll,
    AsyncValue<SurveyResponseModel?>? onGetById,
    AsyncValue<SurveyResponseCreateModel?>? onCreate,
    AsyncValue<SurveyResponseModel?>? onUpdate,
    AsyncValue<SurveyResponseModel?>? onDelete,
  }) {
    return SurveyResponseState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class SurveyResponseNotifier extends StateNotifier<SurveyResponseState> {
  SurveyResponseNotifier({
    required this.repository,
    required this.surveyId,
  }) : super(const SurveyResponseState()) {
    getAll();
  }

  final SurveyResponseRepository repository;
  final String surveyId;

  Future<void> getAll() async {
    state = state.copyWith(onGetAll: const AsyncValue.loading());
    final result = await repository.getAll(surveyId);
    result.fold(
      (failure) => state = state.copyWith(
          onGetAll: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetAll: AsyncValue.data(data)),
    );
  }

  Future<void> getById({
    required String responseId,
  }) async {
    state = state.copyWith(onGetById: const AsyncValue.loading());
    final result = await repository.getById(
      surveyId: surveyId,
      responseId: responseId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onGetById: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetById: AsyncValue.data(data)),
    );
  }

  Future<void> create({
    required FormMachineResponseCreateUpdateModel form,
  }) async {
    state = state.copyWith(onCreate: const AsyncValue.loading());
    final result = await repository.create(
      form: form,
      surveyId: surveyId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onCreate: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onCreate: AsyncValue.data(data)),
    );
  }

  Future<void> update({
    required FormMachineResponseCreateUpdateModel form,
    required String responseId,
  }) async {
    state = state.copyWith(onUpdate: const AsyncValue.loading());
    final result = await repository.update(
      form: form,
      surveyId: surveyId,
      responseId: responseId,
    );
    result.fold(
      (failure) => state = state.copyWith(
          onUpdate: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onUpdate: AsyncValue.data(data)),
    );
  }

  Future<SurveyResponseState> delete({required String responseId}) async {
    state = state.copyWith(onDelete: const AsyncValue.loading());

    final result = await repository.delete(
      surveyId: surveyId,
      responseId: responseId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onDelete: AsyncValue.error(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(onDelete: AsyncValue.data(data)),
    );
  }
}
