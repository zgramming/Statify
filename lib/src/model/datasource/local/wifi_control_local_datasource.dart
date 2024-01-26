import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/failure.dart';
import '../../database/database.dart';
import '../../model/wifi_control/wifi_control.model.dart';

class WifiControlLocalDatasource {
  final MyDatabase database;
  const WifiControlLocalDatasource({
    required this.database,
  });

  Future<WifiControlModel?> getFirstWifiControl() async {
    final result = await database.getFirstWifiControl();
    if (result == null) return null;
    return WifiControlModel(
      id: result.id,
      url: result.url,
    );
  }

  Future<WifiControlModel> upsert(String url) async {
    final body = WifiControlTableCompanion(
      url: Value(url),
    );
    final result = await database.upsertWifiControl(body);

    return result;
  }
}

class WifiControlRepository {
  final WifiControlLocalDatasource localDatasource;
  const WifiControlRepository({
    required this.localDatasource,
  });

  Future<Either<Failure, WifiControlModel?>> getFirstWifiControl() async {
    try {
      final result = await localDatasource.getFirstWifiControl();
      return right(result);
    } catch (e) {
      return left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, WifiControlModel>> upsert(String url) async {
    try {
      final result = await localDatasource.upsert(url);
      return right(result);
    } catch (e) {
      return left(CommonFailure(e.toString()));
    }
  }
}

class WifiControlState extends Equatable {
  final WifiControlModel? item;
  final AsyncValue<WifiControlModel?> onGetFirstWifiControl;
  final AsyncValue<WifiControlModel?> onUpsert;

  const WifiControlState({
    this.item,
    this.onGetFirstWifiControl = const AsyncValue.data(null),
    this.onUpsert = const AsyncValue.data(null),
  });

  @override
  List<Object?> get props => [item, onGetFirstWifiControl, onUpsert];

  @override
  bool get stringify => true;

  WifiControlState copyWith({
    WifiControlModel? item,
    AsyncValue<WifiControlModel?>? onGetFirstWifiControl,
    AsyncValue<WifiControlModel>? onUpsert,
  }) {
    return WifiControlState(
      item: item ?? this.item,
      onGetFirstWifiControl:
          onGetFirstWifiControl ?? this.onGetFirstWifiControl,
      onUpsert: onUpsert ?? this.onUpsert,
    );
  }
}

class WifiControlNotifier extends StateNotifier<WifiControlState> {
  final WifiControlRepository repository;

  WifiControlNotifier({
    required this.repository,
  }) : super(const WifiControlState()) {
    getFirstWifiControl();
  }

  Future<void> getFirstWifiControl() async {
    state = state.copyWith(
      onGetFirstWifiControl: const AsyncValue.loading(),
    );
    final result = await repository.getFirstWifiControl();
    result.fold(
      (l) => state = state.copyWith(
        onGetFirstWifiControl: AsyncValue.error(l.message, StackTrace.current),
        item: null,
      ),
      (r) => state = state.copyWith(
        item: r,
        onGetFirstWifiControl: AsyncValue.data(r),
      ),
    );
  }

  Future<void> upsert(String url) async {
    state = state.copyWith(
      onUpsert: const AsyncValue.loading(),
    );
    final result = await repository.upsert(url);
    result.fold(
      (l) => state = state.copyWith(
        onUpsert: AsyncValue.error(l.message, StackTrace.current),
        item: null,
      ),
      (r) => state = state.copyWith(
        item: r,
        onUpsert: AsyncValue.data(r),
      ),
    );
  }
}
