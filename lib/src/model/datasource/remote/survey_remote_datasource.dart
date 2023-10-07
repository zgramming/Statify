import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../../utils/method_channel.dart';
import '../../model/helper/form/form_survey_create_update.model.dart';
import '../../model/helper/form/form_survey_setting_create_update.model.dart';
import '../../model/helper/form/form_temporary_pending_response_create.model.dart';
import '../../model/send_sms_model.dart';
import '../../model/survey/survey.model.dart';
import '../../model/survey/survey_pending.model.dart';
import '../../model/survey/survey_summary.model.dart';
import '../local/temporary_pending_response_local_datasource.dart';
import 'survey_setting_remote_datasource.dart';

class SurveyRemoteDatasource {
  const SurveyRemoteDatasource({
    required this.client,
    required this.surveySettingRemoteDatasource,
    required this.temporaryPendingResponseLocalDatasource,
  });

  final http.Client client;
  final TemporaryPendingResponseLocalDatasource
      temporaryPendingResponseLocalDatasource;
  final SurveySettingRemoteDatasource surveySettingRemoteDatasource;

  Future<List<SurveyModel>> getAll({
    required String machineId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'] as List<dynamic>;
      final result =
          List<SurveyModel>.from(data.map((x) => SurveyModel.fromJson(x)));

      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel?> getById({
    required String machineId,
    required String surveyId,
  }) async {
    if (surveyId == "-1" || machineId == "-1") return null;

    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (data == null) return null;

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> getByNumber({
    required String number,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/surveys/$number",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<List<SurveySummaryModel>> getVotingSummary({
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/surveys/$surveyId/voting-summary",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final list = data as List<dynamic>;
      final result = List<SurveySummaryModel>.from(
        list.map((x) => SurveySummaryModel.fromJson(x)),
      );
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey summary';
      throw Exception(message);
    }
  }

  Future<Uint8List> getExport({
    required String surveyId,
    required ExportTypeEnum type,
  }) async {
    final currentToken = await FlutterSecureStorageUtils.getTokenAuth();
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/export");
    final request = http.Request('GET', uri);
    request.body = json.encode({
      "type": type.valueString,
    });
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $currentToken",
    });

    final response = await request.send();
    final body = await response.stream.toBytes();

    if (response.statusCode == 200) {
      return body;
    } else {
      const message = "Failed to export survey";
      throw Exception(message);
    }
  }

  Future<SurveyPendingModel?> getPendingResponse({
    required String surveyId,
    required MachineResponsePlatformEnum platform,
  }) async {
    final currentToken = await FlutterSecureStorageUtils.getTokenAuth();
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/pending-response");
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
      final result = SurveyPendingModel.fromJson(data);

      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> create({
    required String machineId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys",
    );
    final response = await client.post(
      uri,
      body: {
        'name': form.name,
        'action': form.action,
        'template': form.template,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];
    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> update({
    required String machineId,
    required String surveyId,
    required FormSurveyCreateOrUpdateModel form,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId",
    );
    final response = await client.patch(
      uri,
      body: {
        'name': form.name,
        'action': form.action,
        'template': form.template,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      // When success update survey, update survey setting for each platform

      // WA Setting
      final formWA = FormSurveySettingCreateUpdateModel(
        usePassword: form.wa?.usePassword ?? false,
        timeout: form.wa?.timeout ?? 0,
        tries: form.wa?.tries ?? 0,
        backoff: form.wa?.backoff ?? 0,
      );
      final formSMS = FormSurveySettingCreateUpdateModel(
        usePassword: form.sms?.usePassword ?? false,
        timeout: form.sms?.timeout ?? 0,
        tries: form.sms?.tries ?? 0,
        backoff: form.sms?.backoff ?? 0,
      );

      await Future.wait(
        [
          surveySettingRemoteDatasource.update(
            form: formSMS,
            settingId: form.sms?.settingId ?? "",
            surveyId: surveyId,
          ),
          surveySettingRemoteDatasource.update(
            form: formWA,
            settingId: form.wa?.settingId ?? "",
            surveyId: surveyId,
          ),
        ],
      );

      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to update survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> active({
    required String machineId,
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId/active",
    );
    final response = await client.patch(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to activated survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> delete({
    required String machineId,
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$surveyId",
    );
    final response = await client.delete(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to delete survey';
      throw Exception(message);
    }
  }

  Future<SurveyModel> reset({
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/surveys/$surveyId/reset",
    );
    final response = await client.delete(uri);
    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      final result = SurveyModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to reset survey';
      throw Exception(message);
    }
  }

  Stream<String?> listenPendingResponse({
    required int simSlot,
    required String surveyId,
  }) async* {
    final methodChannelUtils = MethodChannelUtils();

    while (true) {
      try {
        final pendingResponse = await getPendingResponse(
          surveyId: surveyId,
          platform: MachineResponsePlatformEnum.sms,
        );

        if (pendingResponse == null) {
          yield "Pending Response is not found, wait for 10 seconds to check again";
        } else {
          // Check if pending response is exist in temporary pending response
          final tempPendingResponse =
              await temporaryPendingResponseLocalDatasource
                  .getBySurveyRespondenIdTemporaryPendingResponse(
            surveyRespondenId: pendingResponse.surveyRespondentId,
          );

          // If exist, skip this pending response
          if (tempPendingResponse != null) {
            yield "Pending Response is exist in temporary pending response, skip this pending response";
          } else {
            final number = pendingResponse.respondent.number;

            yield "Pending Response is not exist in temporary pending response, create temporary pending response and send message to $number";

            // create temporary pending response to local database for prevent duplicate
            final form = FormTemporaryPendingResponseCreateModel(
              message: pendingResponse.value,
              phoneNumber: number,
              simSlot: simSlot,
              surveyRespondentId: pendingResponse.surveyRespondentId,
            );

            await temporaryPendingResponseLocalDatasource.create(form);
            // Send SMS to user
            final model = SendSMSModel(
              surveyRespondenResponseId: pendingResponse.id,
              surveyRespondenId: pendingResponse.surveyRespondentId,
              message: pendingResponse.value,
              simSlot: simSlot,
              phoneNumber: number,
            );
            final msg = await methodChannelUtils.sendSMS(model);

            if (!msg) {
              yield "Failed to send message to $number, wait for 10 seconds to check again";
            } else {
              yield "Process to send message to $number, wait for 10 seconds to check again";
            }
          }
        }
      } catch (e) {
        yield "Error When Listen Pending Response: ${e.toString()}";
      }

      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
