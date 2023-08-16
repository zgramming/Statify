import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../model/survey/survey_response_create_response_model.dart';
import '../../model/survey/survey_response_model.dart';

class SurveyResponseRemoteDatasource {
  final http.Client client;
  const SurveyResponseRemoteDatasource({
    required this.client,
  });

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

  Future<SurveyResponseModel> getResponse({
    required String machineId,
  }) async {
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

      return SurveyResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to get survey response');
    }
  }
}
