import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/failure.dart';
import '../model/phone_model.dart';

class PhoneLocalDatasource {
  final Box<PhoneModel> box;
  const PhoneLocalDatasource({
    required this.box,
  });

  Future<String> insert(PhoneModel model) async {
    await box.put(model.id, model);

    return "Berhasil menyimpan Phone";
  }

  Future<String> delete(String id) async {
    await box.delete(id);

    return "Berhasil menghapus Phone";
  }

  List<PhoneModel> getAll() {
    return box.values.toList();
  }
}

class PhoneRepository {
  final PhoneLocalDatasource localDatasource;
  const PhoneRepository({
    required this.localDatasource,
  });

  Future<Either<Failure, String>> insert(PhoneModel model) async {
    try {
      final result = await localDatasource.insert(model);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> delete(String id) async {
    try {
      final result = await localDatasource.delete(id);

      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  List<PhoneModel> getAll() {
    return localDatasource.getAll();
  }
}

class PhoneNotifier extends StateNotifier<PhoneState> {
  final PhoneRepository repository;
  PhoneNotifier({
    required this.repository,
  }) : super(const PhoneState());

  Future<void> insert(PhoneModel model) async {
    state = state.copyWith(onInsert: const AsyncLoading());
    final result = await repository.insert(model);
    result.fold(
      (l) => state = state.copyWith(
        onInsert: AsyncError(l.message, StackTrace.current),
      ),
      (r) => state = state.copyWith(
        onInsert: AsyncData(r),
        items: repository.getAll(),
      ),
    );
  }

  Future<void> delete(String id) async {
    state = state.copyWith(onDelete: const AsyncLoading());
    final result = await repository.delete(id);
    result.fold(
      (l) => state = state.copyWith(
          onDelete: AsyncError(
        l.message,
        StackTrace.current,
      )),
      (r) => state = state.copyWith(
        onDelete: AsyncData(r),
        items: repository.getAll(),
      ),
    );
  }

  List<PhoneModel> getAll() {
    return repository.getAll();
  }
}

class PhoneState extends Equatable {
  final List<PhoneModel> items;
  final AsyncValue? onInsert;
  final AsyncValue? onDelete;

  const PhoneState({
    this.items = const [],
    this.onInsert = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object?> get props => [items, onInsert, onDelete];

  PhoneState copyWith({
    List<PhoneModel>? items,
    AsyncValue? onInsert,
    AsyncValue? onDelete,
  }) {
    return PhoneState(
      items: items ?? this.items,
      onInsert: onInsert ?? this.onInsert,
      onDelete: onDelete ?? this.onDelete,
    );
  }

  @override
  bool get stringify => true;
}
