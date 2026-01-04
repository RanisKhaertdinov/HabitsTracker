import 'package:dio/dio.dart';

String handleDioError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout) {
    return 'Проверьте подключение к интернету';
  }

  if (e.response != null) {
    final statusCode = e.response!.statusCode;
    final data = e.response!.data;

    if (statusCode == 401) return 'Неверный email или пароль';
    if (statusCode == 422) return 'Ошибка валидации данных';
    if (statusCode == 429) return 'Слишком много попыток. Попробуйте позже';

    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? 'Ошибка сервера';
    }
  }
  return "Ошибка сети. Попробуйте позже";
}
