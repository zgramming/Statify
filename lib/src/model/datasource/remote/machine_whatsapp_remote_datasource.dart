import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../utils/constant.dart';
import '../../model/machine/machine_whatsapp_create_response_model.dart';

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
      throw Exception('Failed to create machine');
    }
  }

  Future<dynamic> sendQRCode({required File file}) async {
    final uri = Uri.parse("$kBaseApiUrl/machine-whatsapp/send-qr-code");

    final fileBody = await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'png'),
    );

    final request = http.MultipartRequest('POST', uri)..files.add(fileBody);
    final response = await request.send();
    final data = await response.stream.bytesToString();
    final decodedData = Map<String, dynamic>.from(jsonDecode(data));
    if (response.statusCode == 200) {
      return decodedData;
    } else {
      throw Exception('Failed to send QR Code');
    }
  }

  Future<dynamic> connect({
    required String machineId,
  }) async {
    final uri = Uri.parse("$kBaseApiUrl/machine-whatsapp/$machineId/connect");
    final response = await client.patch(uri);

    final data = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(data));
    if (response.statusCode == 200) {
      return decodedData;
    } else {
      throw Exception('Failed to connect machine');
    }
  }

  Future<dynamic> disconnect({
    required String machineId,
  }) async {
    final uri =
        Uri.parse("$kBaseApiUrl/machine-whatsapp/$machineId/disconnect");
    final response = await client.patch(uri);

    final data = response.body;
    final decodedData = Map<String, dynamic>.from(jsonDecode(data));
    if (response.statusCode == 200) {
      return decodedData;
    } else {
      throw Exception('Failed to disconnect machine');
    }
  }
}
