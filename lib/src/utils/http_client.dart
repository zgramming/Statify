import 'package:http/http.dart' as http;

import 'flutter_secure_storage.dart';

class CustomHTTPClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final isAuthorizationHeaderPresent =
        request.headers.containsKey('Authorization');

    if (!isAuthorizationHeaderPresent) {
      final user = await FlutterSecureStorageUtils.getUserAuth();

      if (user != null) {
        request.headers['Authorization'] = 'Bearer ${user.token}';
      }
    }

    request.headers['Accept'] = 'application/json';
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
