import 'package:dio/dio.dart';
import 'package:frontend/core/exceptions/view/exceptions.dart';

Exception handleDioError(DioException e) {
  if (e.response?.statusCode == 401) {
    return UnauthorizedException('Invalid credentials');
  }
  if (e.response?.statusCode == 400) {
    return ValidationException(e.response?.data['message']);
  }
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return NetworkException('Connection timeout');
  }
  return ServerException('Server error: ${e.message}');
}
