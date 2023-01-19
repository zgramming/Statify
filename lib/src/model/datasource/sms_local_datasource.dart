// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../utils/failure.dart';
import '../model/sms_model.dart';

class SMSLocalDatasource {
  final Box<SMSModel> box;
  SMSLocalDatasource({
    required this.box,
  });

  Future<String> insert(SMSModel model) async {
    await box.put(model.id, model);

    return "Berhasil menyimpan SMS";
  }

  Future<String> delete(String id) async {
    await box.delete(id);

    return "Berhasil menghapus SMS";
  }

  List<SMSModel> getAll() {
    return box.values.toList();
  }
}

class SMSRepository {
  final SMSLocalDatasource localDatasource;
  const SMSRepository({
    required this.localDatasource,
  });

  Future<Either<Failure, String>> insert(SMSModel model) async {
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

  List<SMSModel> getAll() {
    return localDatasource.getAll();
  }
}

class SMSState extends Equatable {
  const SMSState({
    this.items = const [],
    this.onInsert = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  final List<SMSModel> items;
  final AsyncValue<String?> onInsert;
  final AsyncValue<String?> onDelete;

  @override
  List<Object> get props => [items, onInsert, onDelete];

  @override
  bool get stringify => true;

  SMSState copyWith({
    List<SMSModel>? items,
    AsyncValue<String?>? onInsert,
    AsyncValue<String?>? onDelete,
  }) {
    return SMSState(
      items: items ?? this.items,
      onInsert: onInsert ?? this.onInsert,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class SMSNotifier extends StateNotifier<SMSState> {
  final SMSRepository repository;
  SMSNotifier({
    required this.repository,
  }) : super(const SMSState()) {
    getAll();
  }

  Future<void> insert(SMSModel model) async {
    final result = await repository.insert(model);

    result.fold(
      (l) => state =
          state.copyWith(onInsert: AsyncError(l.message, StackTrace.current)),
      (r) => state = state.copyWith(
        onInsert: AsyncData(r),
        items: [...state.items, model],
      ),
    );
  }

  Future<void> delete(String id) async {
    final result = await repository.delete(id);

    result.fold(
      (l) => state = state.copyWith(
        onDelete: AsyncError(l.message, StackTrace.current),
      ),
      (r) => state = state.copyWith(
        onDelete: AsyncData(r),
        items: state.items.where((e) => e.id != id).toList(),
      ),
    );
  }

  void getAll() {
    state = state.copyWith(items: repository.getAll());
  }
}
