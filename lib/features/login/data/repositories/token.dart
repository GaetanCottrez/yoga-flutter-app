import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyAccessToken = '';

  Future setAccessToken(String username) async {
    await storage.write(key: _keyAccessToken, value: username);
  }

  Future<String> getAccessToken() async {
    return await storage.read(key: _keyAccessToken) ?? '';
  }
}
