import 'package:auth/auth.dart';
import 'package:flutter/foundation.dart';

class CredentialsRepository {
  CredentialsRepository({required this.credentialsLocalDataSource});

  @visibleForTesting
  final CredentialsLocalDataSource credentialsLocalDataSource;

  Future<CredentialsData?> getCredentials() async {
    return credentialsLocalDataSource.load();
  }

  Future<void> saveCredentials(CredentialsData? credentials) async {
    if (credentials == null) {
      return credentialsLocalDataSource.delete();
    } else {
      return credentialsLocalDataSource.save(credentials);
    }
  }
}
