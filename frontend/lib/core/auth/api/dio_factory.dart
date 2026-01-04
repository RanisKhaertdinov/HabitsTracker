import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/core/auth/storages/token_storage.dart';

class DioFactory {
  final TokenStorage _tokenStorage;
  
  DioFactory(this._tokenStorage);
  
  Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://0.0.0.0:8080',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    dio.interceptors.add(_createAuthInterceptor());
    
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
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