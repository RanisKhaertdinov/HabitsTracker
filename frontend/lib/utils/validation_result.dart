class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult._(this.isValid, this.errorMessage);

  factory ValidationResult.valid() {
    return ValidationResult._(true, null);
  }

  factory ValidationResult.invalid(String message) {
    return ValidationResult._(false, message);
  }
}
