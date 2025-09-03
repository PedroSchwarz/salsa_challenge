import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:salsa_challenge/app/storage/app_local_storage.dart';
import 'package:salsa_challenge/features/auth/auth.dart';

class CredentialsLocalDataSource {
  CredentialsLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  final _log = Logger('CredentialsLocalDataSource');

  Future<CredentialsData?> load() async {
    try {
      final value = await localStorage.read(LocalStorageKey.credentials);

      if (value == null) {
        return null;
      }

      return CredentialsData.fromJson(jsonDecode(value));
    } catch (e) {
      _log.severe('Error loading credentials', e);
      return null;
    }
  }

  Future<void> save(CredentialsData value) async {
    try {
      await localStorage.write(LocalStorageKey.credentials, jsonEncode(value.toJson()));
    } catch (e) {
      _log.severe('Error saving credentials', e);
      rethrow;
    }
  }

  Future<void> delete() async {
    try {
      await localStorage.delete(LocalStorageKey.credentials);
    } catch (e) {
      _log.severe('Error deleting credentials', e);
      rethrow;
    }
  }
}
