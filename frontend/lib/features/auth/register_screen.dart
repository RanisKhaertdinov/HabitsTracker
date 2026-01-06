import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/auth/api/controller_provider.dart';
import 'package:frontend/core/validators/user_validator.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final UserValidator _userValidator = UserValidator();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_loading || !context.mounted) return;

    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final nameResult = _userValidator.validateNameWithDetails(name);
    if (!nameResult.isValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(nameResult.errorMessage!)));
      return;
    }
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

    setState(() {
      _loading = true;
    });
    try {
      final authController = AuthControllerProvider.getController(context);

      await authController.register(name, email, password);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка входа: $e')));
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
              decoration: const InputDecoration(labelText: "Имя"),
              controller: _nameController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              controller: _emailController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Пароль"),
              controller: _passwordController,
            ),
            ElevatedButton(
              onPressed: _loading ? null : _register,
              child: Text("Зарегистрироваться"),
            ),
            Row(
              children: [
                Text("Уже есть аккаунт?"),
                TextButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  child: Text("Войти"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
