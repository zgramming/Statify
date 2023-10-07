import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../utils/enum.dart';
import '../../model/helper/form/form_survey_responden_response_create.model.dart';
import 'survey_responden_remote_datasource.dart';
import 'survey_responden_response_remote_datasource.dart';

class IncomingMessageRemoteDatasource {
  final http.Client client;
  final SurveyRespondenRemoteDatasource surveyRespondenRemoteDatasource;
  final SurveyRespondenResponseRemoteDatasource
      surveyRespondenResponseRemoteDatasource;

  const IncomingMessageRemoteDatasource({
    required this.client,
    required this.surveyRespondenRemoteDatasource,
    required this.surveyRespondenResponseRemoteDatasource,
  });

  Future<(String, String)> handlingIncomingMessage({
    required String surveyId,
    required String number,
    required String message,
  }) async {
    try {
      // Find number survey is exists or not
      final surveyRespondent =
          await surveyRespondenRemoteDatasource.getByNumber(
        number: number,
        surveyId: surveyId,
      );

      final isSurveyRespondenEmpty = surveyRespondent == null;
      if (isSurveyRespondenEmpty) {
        // We should create new survey
        final result = await surveyRespondenRemoteDatasource.create(
          surveyId: surveyId,
          number: number,
          key: message,
        );
        return (
          "SE_CNS",
          "Survey Empty and Create New Survey. Detail Information : \n\n1.Key: ${result.key} \n\n2.Value: ${result.value} \n\n3.Survey Responden Id: ${result.id} "
        );
      } else {
        final isLocked = surveyRespondent.locked;
        if (isLocked) {
          // We should unlock the survey
          final result = await surveyRespondenRemoteDatasource.unlock(
            surveyRespondenId: surveyRespondent.id,
            surveyId: surveyRespondent.surveyId,
            key: message,
            platform: MachineResponsePlatformEnum.sms.valueString,
          );

          return (
            "SNE_US",
            "Survey Not Empty and Unlock Survey. Detail Information : \n\n1.Key: ${result.key} \n\n2.Value: ${result.value} \n\n3.Survey Responden Id: ${result.id}"
          );
        } else {
          // We should create new survey response

          final form = FormSurveyRespondenResponseCreateModel(
            key: message,
            platform: MachineResponsePlatformEnum.sms.valueString,
            surveyRespondenId: surveyRespondent.id,
          );

          final result =
              await surveyRespondenResponseRemoteDatasource.create(form: form);

          return (
            "SNE_CNSR",
            "Survey Not Empty and Create New Survey Response. Detail Information :\n\n1.Key: ${result.key} \n\n2.Value: ${result.value}\n\n3.Survey Responden Id: ${result.id}"
          );
        }
      }
    } catch (e) {
      log("Error when handling incoming message: $e");
      throw Exception(e.toString());
    }
  }
}
