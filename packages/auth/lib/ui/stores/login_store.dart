import 'package:auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore({required this.authRepository});

  @visibleForTesting
  final AuthRepository authRepository;

  final _log = Logger('LoginStore');

  @readonly
  bool _isSubmitting = false;

  @readonly
  String _email = '';

  @readonly
  String _password = '';

  @readonly
  bool _showPassword = false;

  @readonly
  String? _errorMessage;

  @readonly
  bool _isAuthenticated = false;

  @computed
  bool get canSubmit => _email.isNotEmpty && _password.isNotEmpty && !_isSubmitting;

  @action
  void setEmail(String email) {
    _email = email;
  }

  @action
  void setPassword(String password) {
    _password = password;
  }

  @action
  void toggleShowPassword() {
    _showPassword = !_showPassword;
  }

  @action
  Future<void> login() async {
    _isSubmitting = true;
    _errorMessage = null;

    try {
      final result = await authRepository.login(LoginRequest(email: _email, password: _password));
      switch (result) {
        case LoginResult.success:
          _isAuthenticated = true;
        case LoginResult.userNotFound:
          _handleErrorResult(LoginResult.userNotFound);
        case LoginResult.networkError:
          _handleErrorResult(LoginResult.networkError);
      }
    } catch (e) {
      _log.severe('Error logging in', e);
      _handleErrorResult(LoginResult.networkError);
    } finally {
      _isSubmitting = false;
    }
  }

  void _handleErrorResult(LoginResult result) {
    final message = switch (result) {
      LoginResult.success => null,
      LoginResult.userNotFound => 'User not found. Please check your credentials.',
      LoginResult.networkError => 'An error occurred. Try again later.',
    };

    _errorMessage = message;
  }
}
