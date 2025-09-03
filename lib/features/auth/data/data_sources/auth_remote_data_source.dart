import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:salsa_challenge/features/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(LoginRequest request);
  Future<String> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final _log = Logger('AuthRemoteDataSourceImpl');

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return AuthResponse(
        id: '123',
        accessToken: 'token',
        refreshToken: 'refreshToken',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        createdAt: clock.now(),
      );
    } catch (e) {
      _log.severe('Error logging in', e);
      rethrow;
    }
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    throw UnimplementedError();
  }
}
