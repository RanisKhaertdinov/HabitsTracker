import 'package:auto_route/auto_route.dart';
import 'package:frontend/core/auth/view/auth.dart';
import 'package:frontend/core/routes/router/router.gr.dart';
import 'package:frontend/features/auth/auth_controller.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthController _authController;

  AuthGuard(this._authController);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    void listener() {
      final state = _authController.state.value;

      if (state is AuthAuthenticated) {
        _authController.state.removeListener(listener);
        resolver.next(true);
      } else if (state is AuthUnauthenticated || state is AuthError) {
        _authController.state.removeListener(listener);
        resolver.redirectUntil(
          LoginRoute(
            onLoginResult: (success) {
              if (success) {
                resolver.next(true);
              } else {
                resolver.next(false);
              }
            },
          ),
          replace: true,
        );
      }
    }

    _authController.state.addListener(listener);

    listener();
  }
}
