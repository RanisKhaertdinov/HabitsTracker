import 'package:frontend/models/view/models.dart';

class AuthResult {
  final User user;
  final Tokens tokens;
  
  AuthResult({required this.user, required this.tokens});
}