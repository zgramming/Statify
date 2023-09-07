import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../model/survey_response/survey_response_by_machine_and_type_model.dart';
import '../../model/survey_response/survey_response_create_response_model.dart';
import '../../model/survey_response/survey_response_fail_model.dart';
import '../../model/survey_response/survey_response_sent_model.dart';

class SurveyResponseRemoteDatasource {
  final http.Client client;
  const SurveyResponseRemoteDatasource({
    required this.client,
  });

  Future<SurveyResponseByMachineAndTypeModel> getByMachineAndType(
      String machineId) async {
    final token = (await FlutterSecureStorageUtils.getUserAuth())!.token;
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/pending-response");
    final request = http.Request('GET', uri);
    request.body = json.encode({"type": "whatsapp"});
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    final response = await request.send();

    final body = await response.stream.bytesToString();
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];

      final result = SurveyResponseByMachineAndTypeModel.fromJson(data);

      return result;
    } else {
      throw Exception('Failed to get survey response');
    }
  }

  Future<SurveyResponseCreateResponseModel> create({
    required String surveyId,
    required String key,
    required String type,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/responses");
    final response = await client.post(
      uri,
      body: {
        'key': key,
        'type': type,
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
}
