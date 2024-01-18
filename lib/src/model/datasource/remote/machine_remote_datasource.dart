import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../../utils/flutter_secure_storage.dart';
import '../../model/helper/form/form_machine_create_update.model.dart';
import '../../model/helper/form/form_machine_update_config.model.dart';
import '../../model/machine/machine_create_response_model.dart';
import '../../model/machine/machine_delete_response_model.dart';
import '../../model/machine/machine_model.dart';
import '../../model/machine/machine_summary.model.dart';
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

      final machines = list.map((e) {
        final result = MachineModel.fromJson(e);
        return result;
      }).toList();

      for (final machine in machines) {
        final summary = await getSummary(machine.id);
        machine.copyWith(summary: summary);
      }

      return machines;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine';

      throw Exception(message);
    }
  }

  Future<MachineModel?> getById({
    required String userId,
    required String machineId,
  }) async {
    final uri = Uri.parse('$kBaseApiUrl/users/$userId/machines/$machineId');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (data == null) {
      return null;
    }

    if (response.statusCode == 200) {
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

  Future<MachineSummaryModel> getSummary(String machineId) async {
    final uri = Uri.parse('$kBaseApiUrl/machines/$machineId/summary');
    final response = await client.get(uri);
    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    if (response.statusCode == 200) {
      final data = decoded['data'];
      final result = MachineSummaryModel.fromJson(data);
      return result;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to load machine summary';
      throw Exception(message);
    }
  }

  Future<Uint8List> getExport({
    required String machineId,
    required ExportTypeEnum type,
  }) async {
    final currentToken = await FlutterSecureStorageUtils.getTokenAuth();
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/export");
    final request = http.Request('GET', uri);
    request.body = json.encode({
      "type": type.valueString,
    });
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $currentToken",
    });

    final response = await request.send();
    final body = await response.stream.toBytes();

    if (response.statusCode == 200) {
      return body;
    } else {
      const message = "Failed to export survey";
      throw Exception(message);
    }
  }

  Future<List<String>> getResults(String nameFileResult) async {
    final uri = Uri.parse(nameFileResult);
    final response = await client.get(uri);
    final body = response.body;
    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final splitByEnter =
          body.split("\n").where((element) => element != "").toList();
      return splitByEnter;
    } else {
      const message = "Failed to get results";
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

  Future<MachineModel> _updateLogo(
    String machineId,
    Uint8List fileBytes,
  ) async {
    final currentToken = await FlutterSecureStorageUtils.getTokenAuth();
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/update-logo");
    final request = http.MultipartRequest('POST', uri);

    // Add Headers
    request.headers.addAll({
      "Authorization": "Bearer $currentToken",
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'logo',
        fileBytes,
        filename: 'logo.png',
      ),
    );

    final response = await request.send();
    final body = await response.stream.bytesToString();

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final decoded = Map<String, dynamic>.from(jsonDecode(body));
      final data = decoded['data'];
      final machine = MachineModel.fromJson(data);
      return machine;
    } else {
      const message = "Failed to update logo";
      throw Exception(message);
    }
  }

  Future<MachineModel> updateConfig(FormMachineUpdateConfigModel form) async {
    final uri = Uri.parse(
      '$kBaseApiUrl/machines/${form.machineId}/update-config',
    );

    final isHaveUploadLogo = form.updateLogoFile != null;

    final encodedOperators = form.operators.map((e) => e.toJson()).toList();
    final encodedCountries = form.countries.map((e) => e.toJson()).toList();
    final encodedBoardIps = form.boardIps.map((e) => e.toJson()).toList();

    final formBody = {
      'count': "${form.count}",
      'power': "${form.power}",
      'start': "${form.start}",
      'reboot': "${form.reboot}",
      "boardIps": jsonEncode(encodedBoardIps),
      'flashSms': "${form.flashSms}",
      'wifiName': "${form.wifiName}",
      'autoArfcn': "${form.autoArfcn}",
      'autoReset': "${form.autoReset}",
      "countries": jsonEncode(encodedCountries),
      'operators': jsonEncode(encodedOperators),
      'taskCount': "${form.taskCount}",
      "unallowed": "${form.unallowed}",
      'wifiHidden': "${form.wifiHidden}",
      'powerConfig': "${form.powerConfig}",
      "arfcnLabel2g": "${form.arfcnLabel2g}",
      "arfcnLabel3g": "${form.arfcnLabel3g}",
      "arfcnLabel4g": "${form.arfcnLabel4g}",
      "arfcnLabel5g": "${form.arfcnLabel5g}",
      'saveSentList': "${form.saveSentList}",
      'wifiPassword': "${form.wifiPassword}",
      "arfcnHidden2g": "${form.arfcnHidden2g}",
      "arfcnHidden3g": "${form.arfcnHidden3g}",
      "arfcnHidden4g": "${form.arfcnHidden4g}",
      "arfcnHidden5g": "${form.arfcnHidden5g}",
      "removeManager": "${form.removeManager}",
      "managerPassword": "${form.managerPassword}",

      // new input admin response
      "plmn": "${form.plmn}",
      "band": "${form.band}",
      "allowed": form.allowed ?? "",
      "autoClear": "${form.autoClear}",
      "runningText": "${form.runningText}",
      "adminPassword": "${form.adminPassword}",
      "machineKeyLast": "${form.machineKeyLast}",
      "machineKeyType": "${form.machineKeyType}",

      // new input admin response
      "clientAllowed": form.clientAllowed ?? '',
      "updateLogo": isHaveUploadLogo ? "1" : form.updateLogo ?? "0",
      "removeAdmin": form.removeAdmin ?? "0",
      "hiddenManager": form.hiddenManager ?? "0",
      "allRotation": form.allRotation ?? "0",
      "autoCellId": form.autoCellId ?? "0",
      "twoGData": form.twoGData,
      "fourGData": form.fourGData,
      "twoGDataChanged": form.twoGDataChanged,
      "fourGDataChanged": form.fourGDataChanged,
      "registeredMccMnc": form.registeredMccMnc,

      // Include Sender or sms if not null
      if (form.sender1 != null) 'sender1': "${form.sender1}",
      if (form.sender2 != null) 'sender2': "${form.sender2}",
      if (form.sender3 != null) 'sender3': "${form.sender3}",
      if (form.sender4 != null) 'sender4': "${form.sender4}",
      if (form.sender5 != null) 'sender5': "${form.sender5}",

      if (form.sms1 != null) 'sms1': "${form.sms1}",
      if (form.sms2 != null) 'sms2': "${form.sms2}",
      if (form.sms3 != null) 'sms3': "${form.sms3}",
      if (form.sms4 != null) 'sms4': "${form.sms4}",
      if (form.sms5 != null) 'sms5': "${form.sms5}",
    };

    final mappingFormBody = {
      "config": {...formBody}
    };

    final response = await client.patch(
      uri,
      body: jsonEncode(mappingFormBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = response.body;
    final decoded = Map<String, dynamic>.from(jsonDecode(body));
    final data = decoded['data'];

    if (response.statusCode == 200) {
      final machine = MachineModel.fromJson(data);

      // Update Logo when have file
      if (isHaveUploadLogo) {
        await _updateLogo(machine.id, form.updateLogoFile!);
      }

      return machine;
    } else {
      final message = decoded.containsKey('message')
          ? decoded['message']
          : 'Failed to update machine config';
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
