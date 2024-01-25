import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/application_config/application_config_model.dart';
import '../model/repository/application_config.repository.dart';

class ApplicationConfigState extends Equatable {
  final AsyncValue<List<ApplicationConfigModel>> onGetAll;
  final AsyncValue<ApplicationConfigModel?> onGetByKey;
  final AsyncValue<int> onInsert;
  final AsyncValue<bool> onUpdateByKey;
  final AsyncValue<bool> onDeleteByKey;
  final AsyncValue<ApplicationConfigModel?> onUpsert;

  const ApplicationConfigState({
    this.onGetAll = const AsyncLoading(),
    this.onGetByKey = const AsyncLoading(),
    this.onInsert = const AsyncLoading(),
    this.onUpdateByKey = const AsyncLoading(),
    this.onDeleteByKey = const AsyncLoading(),
    this.onUpsert = const AsyncLoading(),
  });

  @override
  List<Object> get props {
    return [
      onGetAll,
      onGetByKey,
      onInsert,
      onUpdateByKey,
      onDeleteByKey,
      onUpsert,
    ];
  }

  @override
  bool get stringify => true;

  ApplicationConfigState copyWith({
    AsyncValue<List<ApplicationConfigModel>>? onGetAll,
    AsyncValue<ApplicationConfigModel?>? onGetByKey,
    AsyncValue<int>? onInsert,
    AsyncValue<bool>? onUpdateByKey,
    AsyncValue<bool>? onDeleteByKey,
    AsyncValue<ApplicationConfigModel?>? onUpsert,
  }) {
    return ApplicationConfigState(
      onGetAll: onGetAll ?? this.onGetAll,
      onGetByKey: onGetByKey ?? this.onGetByKey,
      onInsert: onInsert ?? this.onInsert,
      onUpdateByKey: onUpdateByKey ?? this.onUpdateByKey,
      onDeleteByKey: onDeleteByKey ?? this.onDeleteByKey,
      onUpsert: onUpsert ?? this.onUpsert,
    );
  }
}

class ApplicationConfigNotifier extends StateNotifier<ApplicationConfigState> {
  final ApplicationConfigRepository repository;
  ApplicationConfigNotifier({
    required this.repository,
  }) : super(const ApplicationConfigState()) {
    getAll();
  }

  Future<void> getAll() async {
    final result = await repository.getAll();
    result.fold(
      (failure) => state = state.copyWith(
        onGetAll: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onGetAll: AsyncData(data)),
    );
  }

  Future<ApplicationConfigState> getByKey(String key) async {
    final result = await repository.getByKey(key);
    final fold = result.fold(
      (failure) => state = state.copyWith(
        onGetByKey: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onGetByKey: AsyncData(data)),
    );

    return fold;
  }

  Future<void> updateByKey({
    required String key,
    required String value,
  }) async {
    final result = await repository.updateByKey(
      key: key,
      value: value,
    );
    result.fold(
      (failure) => state = state.copyWith(
        onUpdateByKey: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onUpdateByKey: AsyncData(data)),
    );
  }

  Future<void> insert({
    required String key,
    required String value,
  }) async {
    final result = await repository.insert(
      key: key,
      value: value,
    );
    result.fold(
      (failure) => state = state.copyWith(
        onInsert: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onInsert: AsyncData(data)),
    );
  }

  Future<void> upsert({
    required String key,
    required String value,
  }) async {
    final result = await repository.upsert(
      key: key,
      value: value,
    );
    result.fold(
      (failure) => state = state.copyWith(
        onUpsert: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onUpsert: AsyncData(data)),
    );
  }

  Future<void> deleteByKey(String key) async {
    final result = await repository.delete(key);
    result.fold(
      (failure) => state = state.copyWith(
        onDeleteByKey: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(onDeleteByKey: AsyncData(data)),
    );
  }
}
