import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../model/survey_responden/survey_responden_by_number.model.dart';
import '../../model/survey_responden/survey_responden_create.model.dart';
import '../../model/survey_responden/survey_responden_unlock.model.dart';

class SurveyRespondenRemoteDatasource {
  final http.Client client;

  const SurveyRespondenRemoteDatasource({
    required this.client,
  });

  Future<SurveyRespondenByNumberModel?> getByNumber({
    required String surveyId,
    required String number,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/respondents/$number");
    final response = await client.get(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (data == null) return null;

    if (response.statusCode == 200) {
      final result = SurveyRespondenByNumberModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to get survey';
      throw Exception(message);
    }
  }

  Future<SurveyRespondenUnlockModel> unlock({
    required String surveyId,
    required String surveyRespondenId,
    required String key,
    required String platform,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/surveys/$surveyId/respondents/$surveyRespondenId/unlock",
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
      final result =
          SurveyRespondenUnlockModel.fromJson(Map<String, dynamic>.from(data));
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to unlock survey';
      throw Exception(message);
    }
  }

  Future<SurveyRespondenCreateModel> create({
    required String number,
    required String surveyId,
    required String? key,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/surveys/$surveyId/respondents");
    final response = await client.post(
      uri,
      body: {
        'number': number,
        'key': key,
        'platform': MachineResponsePlatformEnum.sms.valueString,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];
      final result = SurveyRespondenCreateModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create machine';
      throw Exception(message);
    }
  }
}
