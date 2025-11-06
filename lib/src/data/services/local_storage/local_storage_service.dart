import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userKey = 'user';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readStorage(String key) async {
    return _storage.read(key: key);
  }

  Future<void> deleteStorage(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }

  Future<void> saveUser(String userJson) async {
    await saveStorage(_userKey, userJson);
  }

  Future<void> saveAccessToken(String token) async {
    await saveStorage(_accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    return readStorage(_accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await saveStorage(_refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    return readStorage(_refreshTokenKey);
  }

  Future<String?> getUser() async {
    return readStorage(_userKey);
  }
}
