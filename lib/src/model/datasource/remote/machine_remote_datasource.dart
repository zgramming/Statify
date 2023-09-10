import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/form/form_machine_create_update_model.dart';
import '../../model/machine/machine_create_response_model.dart';
import '../../model/machine/machine_delete_response_model.dart';
import '../../model/machine/machine_model.dart';
import '../../model/machine/machine_update_response_model.dart';

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
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
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
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
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
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineCreateResponseModel> create({
    required FormMachineCreateUpdateModel form,
    required String userId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines');
    final response = await client.post(
      uri,
      body: {
        'name': form.name,
        'number': form.number,
        'license': form.license,
        'serial_number': form.serialNumber,
        'action': form.action,
        'sms_setting': form.smsSetting,
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

  Future<MachineUpdateResponseModel> update({
    required FormMachineCreateUpdateModel form,
    required String machineId,
    required String userId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines/$machineId');
    final response = await client.patch(
      uri,
      body: {
        'name': form.name,
        'serial_number': form.serialNumber,
        'number': form.number,
        'license': form.license,
        'action': form.action,
        'sms_setting': form.smsSetting,
      },
    );
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final result = MachineUpdateResponseModel.fromJson(data);
      return result;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update machine';
      throw Exception(message);
    }
  }

  Future<MachineDeleteResponseModel> delete({
    required String userId,
    required String machineId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines/$machineId');
    final response = await client.delete(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final result = MachineDeleteResponseModel.fromJson(data);
      return result;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to delete machine';
      throw Exception(message);
    }
  }
}
