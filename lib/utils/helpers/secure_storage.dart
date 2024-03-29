import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lixshop/models/auth/token_response.dart';
import 'package:lixshop/models/models.dart';

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

  Future<bool> checkLogin() async {
    return await readToken() != null;
  }

  Future<void> addKey(String key, dynamic value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<dynamic> readKey(String key) async {
    return await secureStorage.read(key: key);
  }

  saveCurrentUser(String user) async {
    await secureStorage.write(key: 'current_user', value: user);
  }

  getCurrentUser() async {
    final user = await secureStorage.read(key: 'current_user');
    if (user == null) return null;
    final currentUser = AuthUser.fromJson(jsonDecode(user));
    return currentUser;
  }


}

final secureStorage = SecureStorageFrave();
