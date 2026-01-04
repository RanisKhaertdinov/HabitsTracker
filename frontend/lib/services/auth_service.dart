import 'package:dio/dio.dart';
import 'package:frontend/core/exceptions/handle_dio_error.dart';
import 'package:frontend/core/auth/view/auth.dart';
import 'package:frontend/utils/auth_result.dart';

class AuthService {
  final Dio _dio;

  AuthService(TokenStorage tokenStorage)
    : _dio = DioFactory(tokenStorage).create();

  Future<AuthResult> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await _dio.post(
        "/auth/register",
        data: {'email': email, 'password': password, 'name': name},
      );

      final authResponse = AuthResponse.fromJson(response.data);

      return AuthResult(user: authResponse.user, tokens: authResponse.tokens);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponse.fromJson(response.data);

      return AuthResult(user: authResponse.user, tokens: authResponse.tokens);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<bool> logout(String refreshToken) async {
    final response = await _dio.post(
      '/auth/logout',
      data: {"refresh_token": refreshToken},
    );
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {"refresh_token": refreshToken},
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }


}
