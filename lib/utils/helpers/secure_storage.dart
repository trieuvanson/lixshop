import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lixshop/models/auth/token_response.dart';

class SecureStorageFrave {
  final secureStorage = const FlutterSecureStorage();

  Future<void> persistenceToken(TokenResponse tokenResponse) async {
    await secureStorage.write(
        key: 'token_response', value: jsonEncode(tokenResponse.toJson()));
  }

  Future<TokenResponse?> readToken() async {
    final token = await secureStorage.read(key: 'token_response');
    if (token != null) {
      return TokenResponse.fromJson(jsonDecode(token));
    }
    return null;
  }

  Future<void> deleteSecureStorage() async {
    await secureStorage.delete(key: 'token_response');
    await secureStorage.deleteAll();
  }
}

final secureStorage = SecureStorageFrave();
