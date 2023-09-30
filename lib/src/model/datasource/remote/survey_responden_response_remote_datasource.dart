import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/helper/form/form_survey_responden_response_create.model.dart';
import '../../model/survey_responden_response/survey_responden_response_create_response_model.dart';
import '../../model/survey_responden_response/survey_responden_response_fail_model.dart';
import '../../model/survey_responden_response/survey_responden_response_sent_model.dart';

class SurveyRespondenResponseRemoteDatasource {
  SurveyRespondenResponseRemoteDatasource({
    required this.client,
  });

  final http.Client client;

  Future<SurveyRespondenResponseCreateResponseModel> create({
    required FormSurveyRespondenResponseCreateModel form,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/survey-respondents/${form.surveyRespondenId}/responses",
    );
    final response = await client.post(
      uri,
      body: {
        'key': form.key,
        'platform': form.platform,
      },
    );

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return SurveyRespondenResponseCreateResponseModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create survey response';
      throw Exception(message);
    }
  }

  Future<SurveyRespondenResponseSentModel> sent({
    required String surveyRespondenId,
    required String surveyRespondenResponseId,
  }) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/survey-respondents/$surveyRespondenId/responses/$surveyRespondenResponseId/sent",
    );
    final response = await client.patch(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return SurveyRespondenResponseSentModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to sent survey response';
      throw Exception(message);
    }
  }

  Future<SurveyRespondenResponseFailModel> fail(
      {required String surveyRespondenId,
      required String surveyRespondenResponseId,
      required}) async {
    final uri = Uri.parse(
      "$kBaseApiUrl/survey-respondents/$surveyRespondenId/responses/$surveyRespondenResponseId/fail",
    );
    final response = await client.patch(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return SurveyRespondenResponseFailModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to fail survey response';
      throw Exception(message);
    }
  }
}
