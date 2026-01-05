import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/auth/api/controller_provider.dart';
import 'package:frontend/core/routes/router/router.gr.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = AuthControllerProvider.getController(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                authController.logout(context);
              },
              child: Text("Выйти"),
            ),
            ElevatedButton(
              onPressed: () async {
                authController.checkAuthStatus(context);
              },
              child: Text("Проверить состояние"),
            ),
          ],
        ),
      ),
    );
  }
}
