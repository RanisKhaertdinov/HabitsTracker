import 'package:frontend/models/view/models.dart';

class AuthResponse {
  final User user;
  final Tokens tokens;

  AuthResponse({required this.user, required this.tokens});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }
}
