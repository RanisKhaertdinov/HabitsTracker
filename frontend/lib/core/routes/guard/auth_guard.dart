import 'package:auto_route/auto_route.dart';
import 'package:frontend/core/routes/router/router.gr.dart';
import 'package:frontend/features/auth/auth_controller.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthController _authController;

  AuthGuard(this._authController);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authController.isAuthenticated) {
      resolver.resolveNext(true, reevaluateNext: false);
    } else {
      resolver.redirectUntil(const LoginRoute(), replace: true);
    }
  }
}
