import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_survey_setting_create_update_model.dart';
import '../model/model/survey_setting/survey_setting_model.dart';
import '../model/repository/survey_setting_repository.dart';

class SurveySettingState extends Equatable {
  final List<SurveySettingModel> items;
  final AsyncValue<List<SurveySettingModel>> onGetAll;
  final AsyncValue<SurveySettingModel?> onGetById;
  final AsyncValue<SurveySettingModel?> onUpdate;
  const SurveySettingState({
    this.items = const [],
    this.onGetAll = const AsyncValue.data([]),
    this.onGetById = const AsyncValue.data(null),
    this.onUpdate = const AsyncValue.data(null),
  });

  @override
  List<Object> get props => [items, onGetAll, onGetById, onUpdate];

  @override
  bool get stringify => true;

  SurveySettingState copyWith({
    List<SurveySettingModel>? items,
    AsyncValue<List<SurveySettingModel>>? onGetAll,
    AsyncValue<SurveySettingModel?>? onGetById,
    AsyncValue<SurveySettingModel?>? onUpdate,
  }) {
    return SurveySettingState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onUpdate: onUpdate ?? this.onUpdate,
    );
  }
}

class SurveySettingNotifier extends StateNotifier<SurveySettingState> {
  final SurveySettingRepository repository;
  final String surveyId;
  SurveySettingNotifier({
    required this.repository,
    required this.surveyId,
  }) : super(const SurveySettingState()) {
    getAll();
  }

  Future<void> getAll() async {
    state = state.copyWith(onGetAll: const AsyncValue.loading());
    final result = await repository.getAll(surveyId);
    result.fold(
      (failure) => state = state.copyWith(
          onGetAll: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(
        onGetAll: AsyncValue.data(data),
        items: data,
      ),
    );
  }

  Future<SurveySettingState> getById({
    required String settingId,
  }) async {
    final result =
        await repository.getById(settingId: settingId, surveyId: surveyId);
    return result.fold(
      (failure) => state = state.copyWith(
          onGetById: AsyncValue.error(failure.message, StackTrace.current)),
      (data) => state = state.copyWith(onGetById: AsyncValue.data(data)),
    );
  }

  Future<SurveySettingState> update({
    required FormSurveySettingCreateUpdateModel form,
    required String settingId,
  }) async {
    state = state.copyWith(onUpdate: const AsyncValue.loading());
    final result = await repository.update(
      form: form,
      settingId: settingId,
      surveyId: surveyId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onUpdate: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onUpdate: AsyncValue.data(data)),
    );
  }
}
