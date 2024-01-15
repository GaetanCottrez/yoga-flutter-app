import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/presentation/pages/home_screen.dart';

class TokenStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyAccessToken = 'access_token';

  Future setAccessToken(String accessToken) async {
    await storage.write(key: _keyAccessToken, value: accessToken);
  }

  Future<String> getAccessToken() async {
    var accessToken = await storage.read(key: _keyAccessToken) ?? '';
    if (accessToken != '' && JwtDecoder.isExpired(accessToken)) {
      MaterialPageRoute(builder: (context) => HomeScreen());
    }
    return await storage.read(key: _keyAccessToken) ?? '';
  }
}
