// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/sms_model.dart';
import '../model/repository/sms_repository.dart';

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
