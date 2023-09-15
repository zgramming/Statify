import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/survey/survey_by_machine_and_number_model.dart';
import '../../model/survey/survey_create_response_model.dart';
import '../../model/survey/survey_unlock_response_model.dart';

class SurveyRemoteDatasource {
  final http.Client client;

  const SurveyRemoteDatasource({
    required this.client,
  });

  Future<SurveyByMachineAndNumberModel?> getByMachineAndNumber({
    required String machineId,
    required String number,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/machines/$machineId/surveys/$number",
    );
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (data == null) return null;

    if (response.statusCode == 200) {
      final result = SurveyByMachineAndNumberModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyUnlockResponseModel> unlock({
    required String surveyId,
    required String key,
    required String platform,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/surveys/$surveyId/unlock",
    );
    final response = await client.patch(
      uri,
      body: {
        'key': key,
        'platform': platform,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];

      final result = SurveyUnlockResponseModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to unlock survey';
      throw Exception(message);
    }
  }

  Future<SurveyCreateResponseModel> create({
    required String number,
    required String machineId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/surveys");
    final response = await client.post(
      uri,
      body: {
        'number': number,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];
      final result = SurveyCreateResponseModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create machine';
      throw Exception(message);
    }
  }
}
