import 'package:flutter/material.dart';
import 'package:frontend/core/auth/view/auth.dart';
import 'package:frontend/core/routes/router/router.dart';
import 'package:frontend/features/auth/auth_controller.dart';
import 'package:frontend/services/view/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(HabitsTracker());
}

class HabitsTracker extends StatefulWidget {
  const HabitsTracker({super.key});
  @override
  State<HabitsTracker> createState() => _HabitsTrackerState();
}

class _HabitsTrackerState extends State<HabitsTracker> {
  // late final AppTheme _appTheme;
  late final AppRouter _appRouter;
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    final tokenStorage = TokenStorage();
    final authService = AuthService(tokenStorage);
    final userDataStorage = UserDataStorage();
    // final _appTheme = AppTheme();

    _authController = AuthController(
      authService,
      tokenStorage,
      userDataStorage,
    );
    _appRouter = AppRouter(_authController);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(reevaluateListenable: _authController),
      builder: (context, child) {
        return AuthControllerProvider(
          authController: _authController,
          child: child!,
        );
      },
    );
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }
}
