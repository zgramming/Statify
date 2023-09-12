import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../../utils/method_channel.dart';
import '../../model/form/form_survey_response_create_model.dart';
import '../../model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../../model/survey_response/survey_response_create_response_model.dart';
import '../../model/survey_response/survey_response_fail_model.dart';
import '../../model/survey_response/survey_response_sent_model.dart';
import 'survey_remote_datasource.dart';

class SurveyResponseRemoteDatasource {
  SurveyResponseRemoteDatasource({
    required this.client,
    required this.surveyRemoteDatasource,
  });

  final http.Client client;
  final SurveyRemoteDatasource surveyRemoteDatasource;

  Future<SurveyResponseByMachineAndTypeModel?> getPendingResponse(
    String machineId,
    MachineResponsePlatformEnum platform,
  ) async {
    final token = (await FlutterSecureStorageUtils.getUserAuth())!.token;
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/pending-response");
    final request = http.Request('GET', uri);
    request.body = json.encode({"platform": platform.valueString});
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
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
    final data = decodedData['data'];
    if (data == null) throw Exception('Failed to sent survey response');

    if (response.statusCode == 200) {
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
    final data = decodedData['data'];
    if (data == null) throw Exception('Failed to fail survey response');

    if (response.statusCode == 200) {
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
    // final simcardProvider = SimCardsProvider();
    // final card = await simcardProvider.getSimCards();
    // log("card: $card");

    // final periodic = Stream.periodic(const Duration(seconds: 1), (i) => i);
    // yield* periodic;

    while (true) {
      try {
        final pendingResponse = await getPendingResponse(
          machineId,
          MachineResponsePlatformEnum.sms,
        );

        if (pendingResponse != null) {
          // Send SMS to user

          final msg = await methodChannelUtils.sendSMS(
            phoneNumber: pendingResponse.survey.number,
            message: pendingResponse.value,
            simSlot: simSlot,
          );

          if (msg) {
            // Update survey response status to sent
            await sent(pendingResponse.id);
            yield "Sent SMS to User successfully, then update survey response status to sent";
          } else {
            await fail(pendingResponse.id);
            yield "Failed to send SMS to User, then update survey response status to fail";
          }
        } else {
          log("Pending Response is null or empty, wait for 10 seconds to check again");
          yield null;
        }
      } catch (e) {
        log("Error When Listen Pending Response: $e");
        yield null;
      }

      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
