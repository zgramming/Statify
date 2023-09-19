import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/helper/form/form_survey_setting_create_update_model.dart';
import '../../model/survey_setting/survey_setting_model.dart';

class SurveySettingRemoteDatasource {
  final http.Client client;
  const SurveySettingRemoteDatasource({
    required this.client,
  });

  Future<List<SurveySettingModel>> getAll(String surveyId) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/settings");
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final result = list.map((e) => SurveySettingModel.fromJson(e)).toList();
      return result;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load survey setting';
      throw Exception(message);
    }
  }

  Future<SurveySettingModel> getById({
    required String surveyId,
    required String settingId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/settings/$settingId");
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (response.statusCode == 200) {
      final machine = SurveySettingModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<SurveySettingModel> update({
    required FormSurveySettingCreateUpdateModel form,
    required String settingId,
    required String surveyId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/settings/$settingId");

    final response = await client.patch(
      uri,
      body: json.encode(
        {
          'use_password': form.usePassword,
          'timeout': form.timeout,
          'tries': form.tries,
          'backoff': form.backoff,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = SurveySettingModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update machine setting';
      throw Exception(message);
    }
  }
}
