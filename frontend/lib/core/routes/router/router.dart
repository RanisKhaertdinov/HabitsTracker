import 'package:auto_route/auto_route.dart';
import 'package:frontend/core/routes/guard/auth_guard.dart';
import 'package:frontend/core/routes/router/router.gr.dart';
import 'package:frontend/features/auth/auth_controller.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthController _authController;

  AppRouter(this._authController);
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(
      guards: [AuthGuard(_authController)],
      page: BottomNavBarRoute.page,
      children: [
        AutoRoute(path: 'habits', page: HabitsRoute.page),
        AutoRoute(path: 'stats', page: StatsRoute.page),
        AutoRoute(path: 'add', page: AddHabitRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
  ];
}
