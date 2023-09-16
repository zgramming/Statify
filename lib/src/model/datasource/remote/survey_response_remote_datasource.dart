import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../../utils/method_channel.dart';
import '../../model/helper/form/form_survey_response_create_model.dart';
import '../../model/helper/form/form_temporary_pending_response_create.model.dart';
import '../../model/send_sms_model.dart';
import '../../model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../../model/survey_response/survey_response_create_response_model.dart';
import '../../model/survey_response/survey_response_fail_model.dart';
import '../../model/survey_response/survey_response_sent_model.dart';
import '../local/temporary_pending_response_local_datasource.dart';
import 'survey_remote_datasource.dart';

class SurveyResponseRemoteDatasource {
  SurveyResponseRemoteDatasource({
    required this.client,
    required this.surveyRemoteDatasource,
    required this.temporaryPendingResponseLocalDatasource,
  });

  final http.Client client;
  final SurveyRemoteDatasource surveyRemoteDatasource;
  final TemporaryPendingResponseLocalDatasource
      temporaryPendingResponseLocalDatasource;

  Future<SurveyResponseByMachineAndTypeModel?> getPendingResponse(
    String machineId,
    MachineResponsePlatformEnum platform,
  ) async {
    final currentToken = await FlutterSecureStorageUtils.getTokenAuth();
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/pending-response");
    final request = http.Request('GET', uri);
    request.body = json.encode({"platform": platform.valueString});
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $currentToken",
    });

    final response = await request.send();

    final body = await response.stream.bytesToString();
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (data == null) {
      return null;
    }

    if (response.statusCode == 200) {
      final result = SurveyResponseByMachineAndTypeModel.fromJson(data);

      return result;
    } else {
      throw Exception('Failed to get survey response');
    }
  }

  Future<SurveyResponseCreateResponseModel> create(
      FormSurveyResponseCreateModel form) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/${form.surveyId}/responses");
    final response = await client.post(
      uri,
      body: {
        'key': form.key,
        'type': form.type,
        'platform': form.platform,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return SurveyResponseCreateResponseModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create survey response';
      throw Exception(message);
    }
  }

  Future<SurveyResponseSentModel> sent(String surveyResponseId) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/survey-responses/$surveyResponseId/sent",
    );
    final response = await client.patch(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return SurveyResponseSentModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to sent survey response';
      throw Exception(message);
    }
  }

  Future<SurveyResponseFailModel> fail(String surveyResponseId) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/survey-responses/$surveyResponseId/fail",
    );
    final response = await client.patch(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return SurveyResponseFailModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to fail survey response';
      throw Exception(message);
    }
  }

  Stream<String?> listenPendingResponse({
    required String machineId,
    required int simSlot,
  }) async* {
    final methodChannelUtils = MethodChannelUtils();

    while (true) {
      try {
        final pendingResponse = await getPendingResponse(
          machineId,
          MachineResponsePlatformEnum.sms,
        );

        if (pendingResponse == null) {
          yield "Pending Response is not found, wait for 10 seconds to check again";
        } else {
          // Check if pending response is exist in temporary pending response
          final tempPendingResponse =
              await temporaryPendingResponseLocalDatasource
                  .getBySurveyResponseId(
            surveyResponseId: pendingResponse.id,
          );

          // If exist, skip this pending response
          log("tempPendingResponse: $tempPendingResponse");
          if (tempPendingResponse != null) {
            log(" Pending Response is exist in temporary pending response, skip this pending response");
            yield "Pending Response is exist in temporary pending response, skip this pending response";
          } else {
            log("Pending Response is not exist in temporary pending response, create temporary pending response and send message to ${pendingResponse.survey.number}");
            // create temporary pending response to local database for prevent duplicate
            final form = FormTemporaryPendingResponseCreateModel(
              surveyId: pendingResponse.survey.id,
              machineId: machineId,
              simSlot: simSlot,
              phoneNumber: pendingResponse.survey.number,
              message: pendingResponse.value,
            );

            await temporaryPendingResponseLocalDatasource.create(form);
            // Send SMS to user
            final model = SendSMSModel(
              phoneNumber: pendingResponse.survey.number,
              message: pendingResponse.value,
              simSlot: simSlot,
              surveyResponseId: pendingResponse.id,
            );
            final msg = await methodChannelUtils.sendSMS(model);

            if (!msg) {
              yield "Failed to send message to ${pendingResponse.survey.number}, wait for 10 seconds to check again";
            } else {
              yield "Process to send message to ${pendingResponse.survey.number}, wait for 10 seconds to check again";
            }
          }
        }
      } catch (e) {
        log("Error When Listen Pending Response: ${e.toString()}");
        yield "Error When Listen Pending Response: ${e.toString()}";
      }

      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
