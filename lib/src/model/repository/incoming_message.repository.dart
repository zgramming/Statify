import 'package:dartz/dartz.dart';

import '../datasource/remote/incoming_message_remote_datasource.dart';

class IncomingMessageRepository {
  final IncomingMessageRemoteDatasource remoteDatasource;

  const IncomingMessageRepository({
    required this.remoteDatasource,
  });

  Future<Either<(String, String), (String, String)>> handlingIncomingMessage({
    required String surveyId,
    required String number,
    required String message,
  }) async {
    try {
      final result = await remoteDatasource.handlingIncomingMessage(
        surveyId: surveyId,
        number: number,
        message: message,
      );
      return Right(result);
    } catch (e) {
      final message = e.toString();
      return Left(("ERROR", message));
    }
  }
}
