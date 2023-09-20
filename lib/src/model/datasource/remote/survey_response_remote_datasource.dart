import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/helper/form/form_machine_response_create_update_model.dart';
import '../../model/survey_response/survey_response_create_response_model.dart';
import '../../model/survey_response/survey_response_model.dart';

class SurveyResponseRemoteDatasource {
  final http.Client client;
  const SurveyResponseRemoteDatasource({
    required this.client,
  });

  Future<List<SurveyResponseModel>> getAll(String surveyId) async {
    final uri = Uri.parse('$kBaseApiUrl/surveys/$surveyId/responses');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final machines =
          list.map((e) => SurveyResponseModel.fromJson(e)).toList();
      return machines;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load survey response';
      throw Exception(message);
    }
  }

  Future<SurveyResponseModel> getById({
    required String responseId,
    required String surveyId,
  }) async {
    final uri = Uri.parse(
      '$kBaseApiUrl/surveys/$surveyId/responses/$responseId',
    );
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = SurveyResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load survey response';
      throw Exception(message);
    }
  }

  Future<SurveyResponseCreateModel> create({
    required FormMachineResponseCreateUpdateModel form,
    required String surveyId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/surveys/$surveyId/responses');
    final bodyForm = Map.from({
      'platform': form.platform,
      'key': form.key,
      'value': form.value,
      'voting': "${form.isVoting ? 1 : 0}",
      'finish': "${form.isFinish ? 1 : 0}",
    });

    final response = await client.post(
      uri,
      body: bodyForm,
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = SurveyResponseCreateModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to create response machine';
      throw Exception(message);
    }
  }

  Future<SurveyResponseModel> update({
    required String responseId,
    required String surveyId,
    required FormMachineResponseCreateUpdateModel form,
  }) async {
    final uri = Uri.parse(
      '$kBaseApiUrl/surveys/$surveyId/responses/$responseId',
    );
    final bodyForm = Map.from({
      "value": form.value,
      "voting": "${form.isVoting ? 1 : 0}",
      "finish": "${form.isFinish ? 1 : 0}",
    });
    final response = await client.patch(
      uri,
      body: bodyForm,
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = SurveyResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update response machine';
      throw Exception(message);
    }
  }

  Future<SurveyResponseModel> delete({
    required String surveyId,
    required String responseId,
  }) async {
    final uri = Uri.parse(
      '$kBaseApiUrl/surveys/$surveyId/responses/$responseId',
    );
    final response = await client.delete(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = SurveyResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to delete response machine';
      throw Exception(message);
    }
  }
}
