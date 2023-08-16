import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/machine/machine_response_setting_create_response_model.dart';
import '../../model/machine/machine_response_setting_model.dart';

class MachineResponseSettingRemoteDatasource {
  final http.Client client;
  const MachineResponseSettingRemoteDatasource({
    required this.client,
  });

  Future<List<MachineResponseSettingModel>> getAll(String idMachine) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$idMachine/response-settings");
    final response = await client.get(uri);

    final body = response.body;
    final decode = Map.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decode['data'] as List;

      final result =
          list.map((e) => MachineResponseSettingModel.fromJson(e)).toList();

      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MachineResponseSettingCreateResponseModel> create({
    required String key,
    required String value,
    required String type,
    required String idMachine,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$idMachine/response-settings");

    final response = await client.post(
      uri,
      body: {
        'key': key,
        'value': value,
        'type': type,
      },
    );

    final body = response.body;
    final decode = Map.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decode['data'];
      final result = MachineResponseSettingCreateResponseModel.fromJson(data);
      return result;
    } else {
      final message = decode.containsKey('message')
          ? decode['message']
          : 'Failed to load data';
      throw Exception(message);
    }
  }
}
