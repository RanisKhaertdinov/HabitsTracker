// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/auth/view/auth.dart';
import 'package:frontend/core/exceptions/view/exceptions.dart';
import 'package:frontend/core/routes/router/router.gr.dart';
import 'package:frontend/core/validators/user_validator.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserValidator _userValidator = UserValidator();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_loading || !context.mounted) return;

    final email = _emailController.text;
    final password = _passwordController.text;

    final emailResult = _userValidator.validateEmailWithDetails(email);
    if (!emailResult.isValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(emailResult.errorMessage!)));
      return;
    }
    final passwordResult = _userValidator.validatePasswordWithDetails(password);
    if (!passwordResult.isValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(passwordResult.errorMessage!)));
      return;
    }

    if (_loading || !context.mounted) return;
    setState(() => _loading = true);

    try {
      final authController = AuthControllerProvider.getController(context);

      await authController.login(email, password);

    } on LoginException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка входа')));
      }
    } finally {
      if (context.mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              controller: _emailController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Пароль"),
              controller: _passwordController,
            ),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: Text("Войти"),
            ),
            Row(
              children: [
                Text("Нет аккаунта?"),
                TextButton(
                  onPressed: () {
                    context.router.push(RegisterRoute());
                  },
                  child: Text("Зарегистрироваться"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
