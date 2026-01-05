import 'package:frontend/utils/validation_result.dart';

class UserValidator {
  ValidationResult validateNameWithDetails(String name) {
    if (name.isEmpty) {
      return ValidationResult.invalid('Введите имя');
    }

    final trimmedName = name.trim();

    if (trimmedName.length < 2) {
      return ValidationResult.invalid('Имя должно быть не менее 2 символов');
    }

    if (trimmedName.length > 50) {
      return ValidationResult.invalid('Имя должно быть не более 50 символов');
    }

    final invalidCharRegex = RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>/?]');
    if (invalidCharRegex.hasMatch(trimmedName)) {
      return ValidationResult.invalid(
        'Имя может содержать только буквы, пробелы, дефис и апостроф',
      );
    }

    if (trimmedName.contains('  ')) {
      return ValidationResult.invalid('Уберите лишние пробелы');
    }

    return ValidationResult.valid();
  }

  ValidationResult validateEmailWithDetails(String email) {
    if (email.isEmpty) {
      return ValidationResult.invalid('Введите email');
    }

    final trimmedEmail = email.trim();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!emailRegex.hasMatch(trimmedEmail)) {
      return ValidationResult.invalid('Введите корректный email');
    }

    return ValidationResult.valid();
  }

  ValidationResult validatePasswordWithDetails(String password) {
    if (password.isEmpty) {
      return ValidationResult.invalid('Введите пароль');
    }

    final List<String> errors = [];

    if (password.length < 8) {
      errors.add('не менее 8 символов');
    }

    // if (!RegExp(r'[A-Z]').hasMatch(password)) {
    //   errors.add('хотя бы одну заглавную букву');
    // }

    // if (!RegExp(r'[a-z]').hasMatch(password)) {
    //   errors.add('хотя бы одну строчную букву');
    // }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add('хотя бы одну цифру');
    }

    if (errors.isNotEmpty) {
      final message =
          'Пароль должен содержать:\n${errors.map((e) => '• $e').join('\n')}';
      return ValidationResult.invalid(message);
    }

    return ValidationResult.valid();
  }
}
