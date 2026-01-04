class Tokens {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;
  final int expiresIn;

  Tokens({
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
    required this.expiresIn,
  });

  factory Tokens.fromJson(Map<String, dynamic> map) {
    final accessToken = map['access_token'] as String?;
    final refreshToken = map['refresh_token'] as String?;
    final expiresIn = map['expires_in'] as int;

    DateTime? expiresAt;
    expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

    return Tokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      expiresIn: expiresIn,
    );
  }
}
