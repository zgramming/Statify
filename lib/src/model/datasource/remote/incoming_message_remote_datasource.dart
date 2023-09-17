import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/enum.dart';
import '../../model/helper/form/form_survey_response_create_model.dart';
import 'survey_remote_datasource.dart';
import 'survey_response_remote_datasource.dart';

class IncomingMessageRemoteDatasource {
  final http.Client client;
  final SurveyRemoteDatasource surveyRemoteDatasource;
  final SurveyResponseRemoteDatasource surveyResponseRemoteDatasource;

  const IncomingMessageRemoteDatasource({
    required this.client,
    required this.surveyRemoteDatasource,
    required this.surveyResponseRemoteDatasource,
  });

  Future<(String, String)> handlingIncomingMessage({
    required String machineId,
    required String number,
    required String message,
  }) async {
    try {
      // Find number survey is exists or not
      final survey = await surveyRemoteDatasource.getByMachineAndNumber(
        machineId: machineId,
        number: number,
      );

      final isSurveyEmpty = survey == null;
      if (isSurveyEmpty) {
        // We should create new survey
        await surveyRemoteDatasource.create(
          machineId: machineId,
          number: number,
          key: message,
        );
        return ("SE_CNS", "Survey Empty and Create New Survey");
      } else {
        final isLocked = survey.locked;

        if (isLocked) {
          // We should unlock the survey
          await surveyRemoteDatasource.unlock(
            surveyId: survey.id,
            key: message,
            platform: MachineResponsePlatformEnum.sms.valueString,
          );

          return ("SNE_US", "Survey Not Empty and Unlock Survey");
        } else {
          // We should create new survey response
          final form = FormSurveyResponseCreateModel(
            surveyId: survey.id,
            key: message,
            platform: MachineResponsePlatformEnum.sms.valueString,
          );

          await surveyResponseRemoteDatasource.create(
            form,
          );

          return (
            "SNE_CNSR",
            "Survey Not Empty and Create New Survey Response"
          );
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class IncomingMessageRepository {
  final IncomingMessageRemoteDatasource remoteDatasource;

  const IncomingMessageRepository({
    required this.remoteDatasource,
  });

  Future<Either<(String, String), (String, String)>> handlingIncomingMessage({
    required String machineId,
    required String number,
    required String message,
  }) async {
    try {
      final result = await remoteDatasource.handlingIncomingMessage(
        machineId: machineId,
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
    required String machineId,
    required String number,
    required String message,
  }) async {
    final result = await repository.handlingIncomingMessage(
      machineId: machineId,
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
