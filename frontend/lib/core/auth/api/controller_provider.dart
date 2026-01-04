import 'package:flutter/material.dart';
import 'package:frontend/features/auth/auth_controller.dart';

class AuthControllerProvider extends InheritedWidget {
  final AuthController authController;
  
  const AuthControllerProvider({
    super.key,
    required this.authController,
    required super.child,
  });
  
  @override
  bool updateShouldNotify(AuthControllerProvider oldWidget) {
    return authController != oldWidget.authController;
  }
  
  static AuthControllerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthControllerProvider>();
  }
  
  static AuthController getController(BuildContext context) {
    final provider = of(context);
    assert(provider != null, 'No AuthControllerProvider found in context');
    return provider!.authController;
  }
}