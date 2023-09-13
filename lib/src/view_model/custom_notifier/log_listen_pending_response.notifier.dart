// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogListenPendingResponseState extends Equatable {
  final List<String?> logs;
  const LogListenPendingResponseState({
    this.logs = const [],
  });

  @override
  List<Object> get props => [logs];

  @override
  bool get stringify => true;

  LogListenPendingResponseState copyWith({
    List<String?>? logs,
  }) {
    return LogListenPendingResponseState(
      logs: logs ?? this.logs,
    );
  }
}

class LogListenPendingResponseNotifier
    extends StateNotifier<LogListenPendingResponseState> {
  LogListenPendingResponseNotifier()
      : super(const LogListenPendingResponseState());

  void addLog(String? message) {
    state = state.copyWith(
      logs: [
        ...state.logs,
        message,
      ],
    );
  }

  void clearLogs() {
    state = const LogListenPendingResponseState();
  }

  void removeLog(int index) {
    state = state.copyWith(
      logs: [
        ...state.logs..removeAt(index),
      ],
    );
  }
}
