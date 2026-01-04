import 'package:frontend/utils/auth_state.dart';

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
