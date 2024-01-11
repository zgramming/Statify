import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../model/helper/form/form_machine_group_create_update.model.dart';
import '../../model/machine_group/machine_group.model.dart';

class MachineGroupRemoteDatasource {
  final http.Client client;
  const MachineGroupRemoteDatasource({
    required this.client,
  });

  Future<List<MachineGroupModel>> getAll(String userId) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machine-groups');

    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final list = decoded['data'] as List;
      final machines = list.map((e) {
        final result = MachineGroupModel.fromJson(e);
        return result;
      }).toList();

      return machines;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel?> getById({
    required String userId,
    required String machineGroupId,
  }) async {
    final uri =
        Uri.parse('$kBaseApiUrl/users/$userId/machine-groups/$machineGroupId');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (data == null) {
      return null;
    }

    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel> create(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    final uri = Uri.parse("$kBaseApiUrl/users/${form.userId}/machine-groups");

    final bodyForm = jsonEncode({
      'master': form.master,
      'copy_setting': form.copySetting ? 1 : 0,
      'copy_sms_setting': form.copySmsSetting ? 1 : 0,
      'name': form.name,
      'machines': form.machineIds,
    });
    final response = await client.post(
      uri,
      body: bodyForm,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];
    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to create machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel> update(
    String machineGroupId,
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    final uri = Uri.parse(
        "$kBaseApiUrl/users/${form.userId}/machine-groups/$machineGroupId");

    final bodyForm = jsonEncode(
      {
        'name': form.name,
        'master': form.master,
        'copy_setting': form.copySetting ? 1 : 0,
        'copy_sms_setting': form.copySmsSetting ? 1 : 0,
        'machines': form.machineIds,
      },
    );

    final response = await client.patch(
      uri,
      body: bodyForm,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];
    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update machine';
      throw Exception(message);
    }
  }

  Future<MachineGroupModel> delete({
    required String userId,
    required String machineGroupId,
  }) async {
    final uri =
        Uri.parse('$kBaseApiUrl/users/$userId/machine-groups/$machineGroupId');
    final response = await client.delete(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (data == null) {
      throw Exception('Failed to delete machine');
    }

    if (response.statusCode == 200) {
      final machine = MachineGroupModel.fromJson(data);
      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to delete machine';
      throw Exception(message);
    }
  }
}
