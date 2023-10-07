import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/repository/incoming_message.repository.dart';

class IncomingMessageState {
  final AsyncValue<(String, String)> onHandlingIncomingMessage;

  IncomingMessageState({
    this.onHandlingIncomingMessage = const AsyncValue.loading(),
  });
}

class IncomingMessageNotifier extends StateNotifier<IncomingMessageState> {
  final IncomingMessageRepository repository;

  IncomingMessageNotifier({
    required this.repository,
  }) : super(IncomingMessageState());

  Future<(String, String)> handlingIncomingMessage({
    required String surveyId,
    required String number,
    required String message,
  }) async {
    final result = await repository.handlingIncomingMessage(
      surveyId: surveyId,
      number: number,
      message: message,
    );

    final fold = result.fold(
      (failure) => failure,
      (data) => data,
    );

    return fold;
  }
}
