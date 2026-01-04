import 'package:frontend/models/view/models.dart';
import 'package:frontend/utils/auth_state.dart';

class AuthAuthenticated extends AuthState {
  final User user;
  final Tokens tokens;

  AuthAuthenticated({required this.user, required this.tokens});
}
