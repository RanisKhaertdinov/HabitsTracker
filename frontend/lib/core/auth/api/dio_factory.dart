import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/auth/storages/token_storage.dart';

class DioFactory {
  final TokenStorage _tokenStorage;

  DioFactory(this._tokenStorage);

  Dio create() {
    final timeout =
        int.tryParse(dotenv.get('API_TIMEOUT', fallback: '10')) ?? 10;
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get('API_BASE_URL', fallback: 'http://localhost:8080'),
        connectTimeout: Duration(seconds: timeout),
        receiveTimeout: Duration(seconds: timeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(_createAuthInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }

    return dio;
  }

  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await _tokenStorage.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
    );
  }
}
