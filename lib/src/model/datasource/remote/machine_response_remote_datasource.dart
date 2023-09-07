// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/form/form_machine_response_create_update_model.dart';
import '../../model/machine_response/machine_response_create_response_model.dart';
import '../../model/machine_response/machine_response_delete_response_model.dart';
import '../../model/machine_response/machine_response_model.dart';

class MachineResponseRemoteDatasource {
  final http.Client client;
  const MachineResponseRemoteDatasource({
    required this.client,
  });

  Future<List<MachineResponseModel>> getAll(String machineId) async {
    final uri = Uri.parse('$kBaseApiUrl/machines/$machineId/responses');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final machines =
          list.map((e) => MachineResponseModel.fromJson(e)).toList();
      return machines;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineResponseModel> getById({
    required String machineId,
    required String responseId,
  }) async {
    final uri =
        Uri.parse('$kBaseApiUrl/machines/$machineId/responses/$responseId');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineResponseCreateResponseModel> create({
    required FormMachineResponseCreateUpdateModel form,
    required String machineId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/machines/$machineId/responses');
    final response = await client.post(
      uri,
      body: {
        'platform': form.platform,
        'key': form.key,
        'value': form.value,
        'type': form.type,
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineResponseCreateResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to create response machine';
      throw Exception(message);
    }
  }

  Future<MachineResponseDeleteResponseModel> delete({
    required String machineId,
    required String responseId,
  }) async {
    final uri =
        Uri.parse('$kBaseApiUrl/machines/$machineId/responses/$responseId');
    final response = await client.delete(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineResponseDeleteResponseModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to delete response machine';
      throw Exception(message);
    }
  }
}
