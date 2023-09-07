// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/form/form_machine_setting_create_update_model.dart';
import '../../model/machine_setting/machine_setting_model.dart';
import '../../model/machine_setting/machine_setting_update_response_model.dart';

class MachineSettingRemoteDatasource {
  final http.Client client;
  const MachineSettingRemoteDatasource({
    required this.client,
  });

  Future<List<MachineSettingModel>> getAll(String machineId) async {
    final uri = Uri.parse('$kBaseApiUrl/machines/$machineId/settings');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final machines =
          list.map((e) => MachineSettingModel.fromJson(e)).toList();
      return machines;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineSettingModel> getById({
    required String machineId,
    required String settingId,
  }) async {
    final uri = Uri.parse(
      '$kBaseApiUrl/machines/$machineId/settings/$settingId',
    );
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineSettingModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineSettingUpdateResponseModel> update({
    required FormMachineSettingCreateUpdateModel form,
    required String settingId,
  }) async {
    final uri = Uri.parse(
      '$kBaseApiUrl/machines/${form.machineId}/settings/$settingId',
    );

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
      final machine = MachineSettingUpdateResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update machine setting';
      throw Exception(message);
    }
  }
}
