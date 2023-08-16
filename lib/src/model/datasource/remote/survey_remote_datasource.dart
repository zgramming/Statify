// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/survey/survey_create_response_model.dart';

class SurveyRemoteDatasource {
  final http.Client client;
  const SurveyRemoteDatasource({
    required this.client,
  });

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
