import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String __accessTokenExpiresInKey = 'access_token_expires_in';
  static const String _createdAtKey = 'created_at';

  Future<void> saveTokens(
    String? accessToken,
    String? refreshToken,
    String? createdAt,
    int expiresIn,
  ) async {
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: accessToken),
      _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
      _secureStorage.write(key: _createdAtKey, value: createdAt),
      _secureStorage.write(
        key: __accessTokenExpiresInKey,
        value: expiresIn.toString(),
      ),
    ]);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<DateTime?> getExpiresAt() async {
    final createdAt = (await _secureStorage.read(key: _createdAtKey)) as String;
    final expiresIn = (await getExpiresIn()) as int;
    return DateTime.parse(createdAt).add(Duration(seconds: expiresIn));
  }

  Future<int?> getExpiresIn() async {
    return int.tryParse(
      (await _secureStorage.read(key: __accessTokenExpiresInKey)) as String,
    );
  }

  Future<String?> getCreatedAt() async {
    return await _secureStorage.read(key: _createdAtKey);
  }

  Future<void> deleteTokens() async {
    await _secureStorage.deleteAll();
  }
}
