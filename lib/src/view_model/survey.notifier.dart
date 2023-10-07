import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_survey_create_update.model.dart';
import '../model/model/survey/survey.model.dart';
import '../model/model/survey/survey_summary.model.dart';
import '../model/repository/survey.repository.dart';
import '../utils/enum.dart';

class SurveyState extends Equatable {
  final List<SurveyModel> items;
  final AsyncValue<List<SurveyModel>?> onGetAll;
  final AsyncValue<SurveyModel?> onGetById;
  final AsyncValue<SurveyModel?> onGetByNumber;
  final AsyncValue<List<SurveySummaryModel>?> onGetVotingSummary;
  final AsyncValue<Uint8List?> onExport;
  final AsyncValue<SurveyModel?> onCreate;
  final AsyncValue<SurveyModel?> onUpdate;
  final AsyncValue<SurveyModel?> onActive;
  final AsyncValue<SurveyModel?> onDelete;
  final AsyncValue<SurveyModel?> onReset;

  const SurveyState({
    this.items = const [],
    this.onGetAll = const AsyncData(null),
    this.onGetById = const AsyncData(null),
    this.onGetByNumber = const AsyncData(null),
    this.onGetVotingSummary = const AsyncData(null),
    this.onExport = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onActive = const AsyncData(null),
    this.onDelete = const AsyncData(null),
    this.onReset = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetAll,
      onGetById,
      onGetByNumber,
      onGetVotingSummary,
      onExport,
      onCreate,
      onUpdate,
      onActive,
      onDelete,
      onReset,
    ];
  }

  @override
  bool get stringify => true;

  SurveyState copyWith({
    List<SurveyModel>? items,
    AsyncValue<List<SurveyModel>?>? onGetAll,
    AsyncValue<SurveyModel?>? onGetById,
    AsyncValue<SurveyModel?>? onGetByNumber,
    AsyncValue<List<SurveySummaryModel>?>? onGetVotingSummary,
    AsyncValue<Uint8List?>? onExport,
    AsyncValue<SurveyModel?>? onCreate,
    AsyncValue<SurveyModel?>? onUpdate,
    AsyncValue<SurveyModel?>? onActive,
    AsyncValue<SurveyModel?>? onDelete,
    AsyncValue<SurveyModel?>? onReset,
  }) {
    return SurveyState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onGetByNumber: onGetByNumber ?? this.onGetByNumber,
      onGetVotingSummary: onGetVotingSummary ?? this.onGetVotingSummary,
      onExport: onExport ?? this.onExport,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onActive: onActive ?? this.onActive,
      onDelete: onDelete ?? this.onDelete,
      onReset: onReset ?? this.onReset,
    );
  }
}

class SurveyNotifier extends StateNotifier<SurveyState> {
  final SurveyRepository repository;
  final String machineId;
  SurveyNotifier({
    required this.repository,
    required this.machineId,
  }) : super(const SurveyState()) {
    getAll();
  }

  Future<SurveyState> getAll() async {
    state = state.copyWith(
      onGetAll: const AsyncLoading(),
      items: [],
    );
    final result = await repository.getAll(machineId: machineId);

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetAll: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) => state = state.copyWith(
        items: data,
        onGetAll: AsyncData(data),
      ),
    );
  }

  Future<SurveyState> getById({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onGetById: const AsyncLoading(),
    );
    final result = await repository.getById(
      machineId: machineId,
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetById: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onGetById: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> getByNumber({
    required String number,
  }) async {
    state = state.copyWith(
      onGetByNumber: const AsyncLoading(),
    );
    final result = await repository.getByNumber(
      number: number,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetByNumber: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onGetByNumber: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> getVotingSummary({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onGetVotingSummary: const AsyncLoading(),
    );
    final result = await repository.getVotingSummary(
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onGetVotingSummary: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onGetVotingSummary: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> getExport({
    required String surveyId,
    required ExportTypeEnum type,
  }) async {
    state = state.copyWith(
      onExport: const AsyncLoading(),
    );
    final result = await repository.getExport(
      surveyId: surveyId,
      type: type,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onExport: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onExport: AsyncData(data),
        );
      },
    );
  }

  Future<SurveyState> create({
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    state = state.copyWith(
      onCreate: const AsyncLoading(),
    );
    final result = await repository.create(
      machineId: machineId,
      form: form,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onCreate: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onCreate: AsyncData(data),
          items: [...state.items, data],
        );
      },
    );
  }

  Future<SurveyState> update({
    required String surveyId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    state = state.copyWith(
      onUpdate: const AsyncLoading(),
    );
    final result = await repository.update(
      machineId: machineId,
      surveyId: surveyId,
      form: form,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onUpdate: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onUpdate: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item,
          ],
        );
      },
    );
  }

  Future<SurveyState> active({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onActive: const AsyncLoading(),
    );
    final result = await repository.active(
      machineId: machineId,
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onActive: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onActive: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item,
          ],
        );
      },
    );
  }

  Future<SurveyState> delete({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onDelete: const AsyncLoading(),
    );
    final result = await repository.delete(
      machineId: machineId,
      surveyId: surveyId,
    );

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onDelete: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        final result = state.items.where((item) => item.id != data.id).toList();
        return state = state.copyWith(
          onDelete: AsyncData(data),
          items: result,
        );
      },
    );
  }

  Future<SurveyState> reset({
    required String surveyId,
  }) async {
    state = state.copyWith(
      onReset: const AsyncLoading(),
    );
    final result = await repository.reset(surveyId: surveyId);

    return result.fold(
      (failure) {
        return state = state.copyWith(
          onReset: AsyncError(failure.message, StackTrace.current),
        );
      },
      (data) {
        return state = state.copyWith(
          onReset: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item,
          ],
        );
      },
    );
  }

  Stream<String?> listenPendingResponse({
    required int simSlot,
    required String surveyId,
  }) {
    final result = repository.listenPendingResponse(
      simSlot: simSlot,
      surveyId: surveyId,
    );

    return result;
  }
}
