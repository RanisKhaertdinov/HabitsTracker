import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _accessTokenExpiresAtKey = 'access_token_expires_at';
  static const String __accessTokenExpiresInKey = 'access_token_expires_in';

  Future<void> saveTokens(
    String? accessToken,
    String? refreshToken,
    int expiresIn,
  ) async {
    final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: accessToken),
      _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
      _secureStorage.write(
        key: _accessTokenExpiresAtKey,
        value: expiresAt.toIso8601String(),
      ),
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
    final expiresAtString = await _secureStorage.read(
      key: _accessTokenExpiresAtKey,
    );

    if (expiresAtString == null) return null;

    try {
      return DateTime.parse(expiresAtString);
    } catch (e) {
      return null;
    }
  }

  Future<int?> getExpiresIn() async {
    return int.tryParse(_secureStorage.read(key: __accessTokenExpiresInKey) as String);
  }

  Future<void> deleteTokens() async {
    await _secureStorage.deleteAll();
  }
}
