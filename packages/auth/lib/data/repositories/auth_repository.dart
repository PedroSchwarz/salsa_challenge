import 'package:auth/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepository {
  AuthRepository({required this.authRemoteDataSource, required this.userRepository, required this.credentialsRepository});

  @visibleForTesting
  final AuthRemoteDataSource authRemoteDataSource;

  @visibleForTesting
  final UserRepository userRepository;

  @visibleForTesting
  final CredentialsRepository credentialsRepository;

  ValueStream<UserData?> get currentUser => userRepository.userStream;

  final _log = Logger('AuthRepository');

  Future<void> init() async {
    await userRepository.init();
  }

  Future<LoginResult> login(LoginRequest request) async {
    try {
      final response = await authRemoteDataSource.login(request);

      /// Updates the user repository.
      await userRepository.updateUser(UserData(id: response.id, firstName: response.firstName, lastName: response.lastName, email: response.email));

      /// Updates the credentials repository.
      await credentialsRepository.saveCredentials(CredentialsData(accessToken: response.accessToken, refreshToken: response.refreshToken));

      return LoginResult.success;
    } catch (e) {
      _log.severe('Error logging in', e);
      return LoginResult.networkError;
    }
  }

  Future<void> signOut() async {
    await credentialsRepository.saveCredentials(null);
    await userRepository.updateUser(null);
  }
}

enum LoginResult { success, userNotFound, networkError }
