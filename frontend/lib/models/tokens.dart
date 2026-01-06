class Tokens {
  final String? accessToken;
  final String? refreshToken;
  final String? createdAt;
  final int? expiresIn;

  Tokens({
    this.accessToken,
    this.refreshToken,
    this.createdAt,
    required this.expiresIn,
  });

  factory Tokens.fromJson(Map<String, dynamic> map) {
    final accessToken = map['accessToken'] as String?;
    final refreshToken = map['refreshToken'] as String?;
    final expiresIn = map['expiresIn'] as int;
    final createdAt = map['createdAt'] as String?;

    return Tokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      createdAt: createdAt,
      expiresIn: expiresIn,
    );
  }
}
