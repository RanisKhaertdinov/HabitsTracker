import 'package:flutter/material.dart';
import 'package:frontend/core/router/router.dart';

void main() {
  runApp(HabitsTracker());
}

class HabitsTracker extends StatelessWidget {
  HabitsTracker({super.key});

  final _appRouter = AppRouter();
  // final _appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      // theme: _appTheme.getLightTheme(context),
    );
  }
}
