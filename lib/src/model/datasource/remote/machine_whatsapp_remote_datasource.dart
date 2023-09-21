import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../utils/constant.dart';
import '../../model/machine_whatsapp/machine_whatsapp_connected_response_model.dart';
import '../../model/machine_whatsapp/machine_whatsapp_create_response_model.dart';
import '../../model/machine_whatsapp/machine_whatsapp_delete_response_model.dart';
import '../../model/machine_whatsapp/machine_whatsapp_disconnected_response_model.dart';
import '../../model/machine_whatsapp/machine_whatsapp_send_qrcode_response_model.dart';

class MachineWhatsappRemoteDatasource {
  final http.Client client;
  const MachineWhatsappRemoteDatasource({
    required this.client,
  });

  Future<MachineWhatsappCreateResponseModel> create({
    required String number,
    required String machineId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machines/$machineId/whatsapps");
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
      return MachineWhatsappCreateResponseModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to create machine whatsapp';
      throw Exception(message);
    }
  }

  Future<MachineWhatsappDeleteResponseModel> delete(
      String machineWhatsappId) async {
    final uri = Uri.parse("$kBaseApiUrl/machine-whatsapps/$machineWhatsappId");
    final response = await client.delete(uri);

    final body = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(body));
    final data = decodedData['data'];

    if (response.statusCode == 200) {
      return MachineWhatsappDeleteResponseModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to delete machine whatsapp';
      throw Exception(message);
    }
  }

  Future<MachineWhatsappSendQRCodeResponseModel> sendQRCode({
    required File file,
    required String number,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machine-whatsapps/$number/qr-code");

    final fileBody = await http.MultipartFile.fromPath(
      'qr_code',
      file.path,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'png'),
    );

    final request = http.MultipartRequest('POST', uri)..files.add(fileBody);
    final response = await request.send();
    final data = await response.stream.bytesToString();
    final decodedData = Map<String, dynamic>.from(jsonDecode(data));
    if (response.statusCode == 200) {
      final data = decodedData['data'];
      return MachineWhatsappSendQRCodeResponseModel.fromJson(data);
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to send qr code';
      throw Exception(message);
    }
  }

  Future<MachineWhatsappConnectedResponseModel> connect({
    required String machineWhatsappId,
  }) async {
    final uri =
        Uri.parse("$kBaseApiUrl/machine-whatsapps/$machineWhatsappId/connect");
    final response = await client.patch(uri);

    final data = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(data));
    if (response.statusCode == 200) {
      final data = decodedData['data'];
      final result = MachineWhatsappConnectedResponseModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to connect machine';
      throw Exception(message);
    }
  }

  Future<MachineWhatsappDisconnectedResponseModel> disconnect({
    required String machineWhatsappId,
  }) async {
    final uri = Uri.parse(
        "$kBaseApiUrl/machine-whatsapps/$machineWhatsappId/disconnect");
    final response = await client.patch(uri);

    final data = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(data));
    if (response.statusCode == 200) {
      final data = decodedData['data'];
      final result = MachineWhatsappDisconnectedResponseModel.fromJson(data);
      return result;
    } else {
      final message = decodedData.containsKey('message')
          ? decodedData['message']
          : 'Failed to disconnect machine';
      throw Exception(message);
    }
  }
}
