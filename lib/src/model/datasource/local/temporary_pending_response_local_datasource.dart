// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/failure.dart';
import '../../database/database.dart';
import '../../model/helper/form/form_temporary_pending_response_create.model.dart';
import '../../model/temporary_pending_response/temporary_pending_response.model.dart';

class TemporaryPendingResponseLocalDatasource {
  final MyDatabase database;
  const TemporaryPendingResponseLocalDatasource({
    required this.database,
  });

  Stream<List<TemporaryPendingResponseModel>> listenNewChange() {
    final query = database.listenNewTemporaryPendingResponse().map(
          (event) => event
              .map((e) => TemporaryPendingResponseModel.fromData(e))
              .toList(),
        );

    return query;
  }

  Future<List<TemporaryPendingResponseModel>> getAll() async {
    final result = await database.getAllTemporaryPendingResponse();

    return result
        .map((e) => TemporaryPendingResponseModel.fromData(e))
        .toList();
  }

  Future<TemporaryPendingResponseModel?>
      getBySurveyRespondenIdTemporaryPendingResponse({
    required String surveyRespondenId,
  }) async {
    final result =
        await database.getBySurveyRespondenIdTemporaryPendingResponse(
      surveyRespondenId: surveyRespondenId,
    );

    if (result == null) {
      return null;
    }

    return TemporaryPendingResponseModel.fromData(result);
  }

  Future<TemporaryPendingResponseModel> create(
    FormTemporaryPendingResponseCreateModel form,
  ) async {
    final result = await database.createTemporaryPendingResponse(
      TemporaryPendingResponseTableCompanion(
        surveyRespondentId: Value(form.surveyRespondentId),
        simSlot: Value(form.simSlot),
        phoneNumber: Value(form.phoneNumber),
        message: Value(form.message),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return TemporaryPendingResponseModel.fromData(result);
  }

  Future<int> deleteAll() async {
    final result = await database.deleteAllTemporaryPendingResponse();

    return result;
  }

  Future<bool> deleteBySurveyRespondenIdTemporaryPendingResponse({
    required String surveyRespondenId,
  }) async {
    final result =
        await database.deleteBySurveyRespondenIdTemporaryPendingResponse(
      surveyRespondenId: surveyRespondenId,
    );

    return result;
  }
}

class TemporaryPendingResponseRepository {
  final TemporaryPendingResponseLocalDatasource localDatasource;
  const TemporaryPendingResponseRepository({
    required this.localDatasource,
  });

  Stream<List<TemporaryPendingResponseModel>> listenNewChange() {
    return localDatasource.listenNewChange();
  }

  Future<Either<Failure, TemporaryPendingResponseModel?>>
      getBySurveyRespondenIdTemporaryPendingResponse({
    required String surveyRespondenId,
  }) async {
    try {
      final result =
          await localDatasource.getBySurveyRespondenIdTemporaryPendingResponse(
        surveyRespondenId: surveyRespondenId,
      );

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, TemporaryPendingResponseModel>> create(
    FormTemporaryPendingResponseCreateModel form,
  ) async {
    try {
      final result = await localDatasource.create(form);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<TemporaryPendingResponseModel>>> getAll() async {
    try {
      final result = await localDatasource.getAll();

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteAll() async {
    try {
      final result = await localDatasource.deleteAll();

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>>
      deleteBySurveyRespondenIdTemporaryPendingResponse({
    required String surveyRespondenId,
  }) async {
    try {
      final result = await localDatasource
          .deleteBySurveyRespondenIdTemporaryPendingResponse(
              surveyRespondenId: surveyRespondenId);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

class TemporaryPendingResponseState extends Equatable {
  final List<TemporaryPendingResponseModel> items;
  final AsyncValue<TemporaryPendingResponseModel?> onGetBySurveyRespondenId;
  final AsyncValue<TemporaryPendingResponseModel?> onCreate;
  final AsyncValue<List<TemporaryPendingResponseModel>?> onGetAll;
  final AsyncValue<int?> onDeleteAll;
  final AsyncValue<bool?> onDeleteBySurveyRespondenId;

  const TemporaryPendingResponseState({
    this.items = const [],
    this.onGetBySurveyRespondenId = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onGetAll = const AsyncData([]),
    this.onDeleteAll = const AsyncData(null),
    this.onDeleteBySurveyRespondenId = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetBySurveyRespondenId,
      onCreate,
      onGetAll,
      onDeleteAll,
      onDeleteBySurveyRespondenId,
    ];
  }

  @override
  bool get stringify => true;

  TemporaryPendingResponseState copyWith({
    List<TemporaryPendingResponseModel>? items,
    AsyncValue<TemporaryPendingResponseModel?>? onGetBySurveyRespondenId,
    AsyncValue<TemporaryPendingResponseModel?>? onCreate,
    AsyncValue<List<TemporaryPendingResponseModel>?>? onGetAll,
    AsyncValue<int?>? onDeleteAll,
    AsyncValue<bool?>? onDeleteBySurveyRespondenId,
  }) {
    return TemporaryPendingResponseState(
      items: items ?? this.items,
      onGetBySurveyRespondenId:
          onGetBySurveyRespondenId ?? this.onGetBySurveyRespondenId,
      onCreate: onCreate ?? this.onCreate,
      onGetAll: onGetAll ?? this.onGetAll,
      onDeleteAll: onDeleteAll ?? this.onDeleteAll,
      onDeleteBySurveyRespondenId:
          onDeleteBySurveyRespondenId ?? this.onDeleteBySurveyRespondenId,
    );
  }
}

class TemporaryPendingResponseNotifier
    extends StateNotifier<TemporaryPendingResponseState> {
  final TemporaryPendingResponseRepository repository;

  TemporaryPendingResponseNotifier({
    required this.repository,
  }) : super(const TemporaryPendingResponseState()) {
    // deleteAll();
    getAll();
  }

  Future<TemporaryPendingResponseState> getAll() async {
    state = state.copyWith(
      onGetAll: const AsyncLoading(),
    );

    final result = await repository.getAll();

    return result.fold(
      (failure) => state = state.copyWith(
        onGetAll: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(
        onGetAll: AsyncData(data),
        items: data,
      ),
    );
  }

  Future<TemporaryPendingResponseState> getBySurveyResponseId({
    required String surveyRespondenId,
  }) async {
    state = state.copyWith(
      onGetBySurveyRespondenId: const AsyncLoading(),
    );

    final result =
        await repository.getBySurveyRespondenIdTemporaryPendingResponse(
      surveyRespondenId: surveyRespondenId,
    );

    return result.fold(
      (failure) => state = state.copyWith(
        onGetBySurveyRespondenId: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(
        onGetBySurveyRespondenId: AsyncData(data),
      ),
    );
  }

  Future<TemporaryPendingResponseState> create(
    FormTemporaryPendingResponseCreateModel form,
  ) async {
    state = state.copyWith(
      onCreate: const AsyncLoading(),
    );

    final result = await repository.create(form);

    return result.fold(
      (failure) => state = state.copyWith(
        onCreate: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(
        onCreate: AsyncData(data),
        items: [
          ...state.items,
          data,
        ],
      ),
    );
  }

  Future<TemporaryPendingResponseState> deleteAll() async {
    state = state.copyWith(
      onDeleteAll: const AsyncLoading(),
    );

    final result = await repository.deleteAll();

    return result.fold(
      (failure) => state = state.copyWith(
        onDeleteAll: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(
        onDeleteAll: AsyncData(data),
        items: [],
      ),
    );
  }

  Future<TemporaryPendingResponseState> deleteBySurveyResponseId({
    required String surveyRespondenId,
  }) async {
    state = state.copyWith(
      onDeleteBySurveyRespondenId: const AsyncLoading(),
    );

    final result =
        await repository.deleteBySurveyRespondenIdTemporaryPendingResponse(
      surveyRespondenId: surveyRespondenId,
    );

    return result.fold(
      (failure) => state = state.copyWith(
        onDeleteBySurveyRespondenId: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (data) => state = state.copyWith(
        onDeleteBySurveyRespondenId: AsyncData(data),
        items: state.items.where((element) {
          return element.surveyRespondenId != surveyRespondenId;
        }).toList(),
      ),
    );
  }

  Stream<List<TemporaryPendingResponseModel>> listenNewChange() {
    return repository.listenNewChange();
  }
}
