// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/machine/machine_create_response_model.dart';
import '../../model/machine/machine_model.dart';

class MachineRemoteDatasource {
  final http.Client client;
  const MachineRemoteDatasource({
    required this.client,
  });

  Future<List<MachineModel>> getAll(String userId) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final machines = list.map((e) => MachineModel.fromJson(e)).toList();
      return machines;
    } else {
      throw Exception('Failed to load machines');
    }
  }

  Future<MachineModel> getById({
    required String userId,
    required String machineId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines/$machineId');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineModel.fromJson(data);
      return machine;
    } else {
      throw Exception('Failed to load machine');
    }
  }

  Future<MachineModel> getByNumber({
    required String userId,
    required String machineNumber,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/machines/$machineNumber');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));

    if (response.statusCode == 200) {
      final data = decoded['data'];
      final machine = MachineModel.fromJson(data);
      return machine;
    } else {
      throw Exception('Failed to load machine');
    }
  }

  Future<MachineCreateResponseModel> create({
    required String number,
    required String license,
    required String action,
    required String smsSetting,
    required String userId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines');
    final response = await client.post(
      uri,
      body: {
        'number': number,
        'license': license,
        'action': action,
        'sms_setting': smsSetting,
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final result = MachineCreateResponseModel.fromJson(data);
      return result;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to create machine';
      throw Exception(message);
    }
  }
}
