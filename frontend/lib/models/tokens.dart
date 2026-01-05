class Tokens {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;
  final int? expiresIn;

  Tokens({
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
    required this.expiresIn,
  });

  factory Tokens.fromJson(Map<String, dynamic> map) {
    final accessToken = map['accessToken'] as String?;
    final refreshToken = map['refreshToken'] as String?;
    final expiresIn = map['expiresIn'] as int;

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
