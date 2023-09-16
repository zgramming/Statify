import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogIncomingMessageState extends Equatable {
  final List<(String, String)> logs;

  const LogIncomingMessageState({
    this.logs = const [],
  });

  @override
  List<Object> get props => [logs];

  @override
  bool get stringify => true;

  LogIncomingMessageState copyWith({
    List<(String, String)>? logs,
  }) {
    return LogIncomingMessageState(
      logs: logs ?? this.logs,
    );
  }
}

class LogIncomingMessageNotifier
    extends StateNotifier<LogIncomingMessageState> {
  LogIncomingMessageNotifier() : super(const LogIncomingMessageState());

  void addLog({
    required String message,
    required String type,
  }) {
    state = state.copyWith(
      logs: [...state.logs, (type, message)],
    );
  }

  void clearLogs() {
    state = const LogIncomingMessageState();
  }

  void removeLog(int index) {
    state = state.copyWith(
      logs: [
        ...state.logs..removeAt(index),
      ],
    );
  }
}
