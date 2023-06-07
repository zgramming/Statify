import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';

import '../model/model/sms_model.dart';
import '../model/repository/sms_repository.dart';

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

  Future<void> sendSMS({
    String to = '',
    String message = '',
  }) async {
    state = state.copyWith(
      onSendSMS: const AsyncLoading(),
    );

    final result = await AsyncValue.guard(() async {
      final telephony = Telephony.instance;

      await telephony.sendSms(
        to: to,
        message: message,
      );

      return 'SMS sent';
    });

    state = state.copyWith(onSendSMS: result);
  }

  void getAll() {
    state = state.copyWith(items: repository.getAll());
  }
}

class SMSState extends Equatable {
  const SMSState({
    this.items = const [],
    this.onInsert = const AsyncData(null),
    this.onDelete = const AsyncData(null),
    this.onSendSMS = const AsyncData(null),
  });

  final List<SMSModel> items;
  final AsyncValue<String?> onInsert;
  final AsyncValue<String?> onDelete;
  final AsyncValue<String?> onSendSMS;

  @override
  List<Object> get props => [items, onInsert, onDelete, onSendSMS];

  @override
  bool get stringify => true;

  SMSState copyWith({
    List<SMSModel>? items,
    AsyncValue<String?>? onInsert,
    AsyncValue<String?>? onDelete,
    AsyncValue<String?>? onSendSMS,
  }) {
    return SMSState(
      items: items ?? this.items,
      onInsert: onInsert ?? this.onInsert,
      onDelete: onDelete ?? this.onDelete,
      onSendSMS: onSendSMS ?? this.onSendSMS,
    );
  }
}
