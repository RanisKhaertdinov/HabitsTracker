import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/view/models.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/view/utils.dart';
import 'package:frontend/core/exceptions/view/exceptions.dart';
import 'package:frontend/core/auth/view/auth.dart';

class AuthController {
  final AuthService _authService;
  final TokenStorage _tokenStorage;
  final UserDataStorage _userDataStorage;

  AuthController(this._authService, this._tokenStorage, this._userDataStorage);

  final _state = ValueNotifier<AuthState>(AuthInitial());
  ValueNotifier<AuthState> get state => _state;

  void _changeState(AuthState newState) {
    _state.value = newState;
  }

  void dispose() {
    _state.dispose();
  }

  Future<void> _clearAllData() async {
    await Future.wait([
      _tokenStorage.deleteTokens(),
      _userDataStorage.deleteUserData(),
    ]);
  }

  Future<void> login(String email, String password) async {
    try {
      _changeState(AuthLoading());
      final response = await _authService.login(email, password);
      await _authenticate(response);
    } on DioException catch (e) {
      final message = handleDioError(e);
      _changeState(AuthError(message: message));
      throw LoginException(message);
    } on StorageException catch (e) {
      _changeState(
        AuthError(message: 'Ошибка сохранения данных: ${e.message}'),
      );
      throw LoginException(e.message);
    } catch (e, stackTrace) {
      debugPrint('Unexpected login error: $e\n$stackTrace');
      _changeState(AuthError(message: 'Неизвестная ошибка'));
      throw LoginException("Сервер не отвечает");
    }
  }

  Future<void> _authenticate(AuthResult response) async {
    final tokens = response.tokens;
    await _tokenStorage.saveTokens(
      tokens.accessToken,
      tokens.refreshToken,
      tokens.expiresIn,
    );
    _changeState(AuthAuthenticated(user: response.user, tokens: tokens));
  }

  Future<void> register(String name, String email, String password) async {
    try {
      _changeState(AuthLoading());
      final response = await _authService.register(email, password, name);
      await _authenticate(response);
    } on DioException catch (e) {
      final message = handleDioError(e);
      _changeState(AuthError(message: message));
      throw RegisterException(message);
    } on StorageException catch (e) {
      _changeState(
        AuthError(message: 'Ошибка сохранения данных: ${e.message}'),
      );
      throw RegisterException(e.message);
    } catch (e, stackTrace) {
      debugPrint('Unexpected login error: $e\n$stackTrace');
      _changeState(AuthError(message: 'Неизвестная ошибка'));
      throw RegisterException("Сервер не отвечает");
    }
  }

  Future<void> logout() async {
    try {
      _changeState(AuthLoading());
      _authService.logout(await _tokenStorage.getRefreshToken() as String);
    } on DioException catch (e) {
      debugPrint('Logout API failed: $e');
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      await _clearAllData();
      _changeState(AuthUnauthenticated());
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      _changeState(AuthLoading());
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        await logout();
        return;
      }
      final expiresAt = await _tokenStorage.getExpiresAt();
      if (expiresAt == null || DateTime.now().isAfter(expiresAt)) {
        final data = await _authService.refresh(refreshToken);
        await _tokenStorage.saveTokens(
          data['access_token'],
          refreshToken,
          data['expires_in'],
        );
      }
      final userData = await _authService.getUser();
      _userDataStorage.saveUser(
        userData['id'],
        userData['name'],
        userData['email'],
      );
      _changeState(
        AuthAuthenticated(
          user: await _userDataStorage.getUserData(),
          tokens: Tokens(
            accessToken: await _tokenStorage.getAccessToken(),
            refreshToken: await _tokenStorage.getRefreshToken(),
            expiresIn: await _tokenStorage.getExpiresIn(),
            expiresAt: await _tokenStorage.getExpiresAt(),
          ),
        ),
      );
    } on DioException catch (e) {
      final message = handleDioError(e);
      _changeState(AuthError(message: message));
    } catch (e) {
      await logout();
    }
  }
}
