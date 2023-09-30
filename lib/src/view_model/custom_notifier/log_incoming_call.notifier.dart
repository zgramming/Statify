import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/incoming_call_model.dart';

class LogIncomingCallState extends Equatable {
  final List<IncomingCallModel> items;
  const LogIncomingCallState({
    this.items = const [],
  });

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  LogIncomingCallState copyWith({
    List<IncomingCallModel>? items,
  }) {
    return LogIncomingCallState(
      items: items ?? this.items,
    );
  }
}

class LogIncomingCallNotifier extends StateNotifier<LogIncomingCallState> {
  LogIncomingCallNotifier() : super(const LogIncomingCallState());

  void addLog(IncomingCallModel item) {
    if (item.number == null) return;

    final items = [item, ...state.items];
    state = state.copyWith(items: items);
  }

  void clear() {
    state = const LogIncomingCallState();
  }
}
