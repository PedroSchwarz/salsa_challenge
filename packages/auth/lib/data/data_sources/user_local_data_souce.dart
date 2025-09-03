import 'dart:convert';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class UserLocalDataSource {
  UserLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  final _log = Logger('UserLocalDataSource');

  Future<UserData?> load() async {
    try {
      final value = await localStorage.read(LocalStorageKey.user);

      if (value == null) {
        return null;
      }

      return UserData.fromJson(jsonDecode(value));
    } catch (e) {
      _log.severe('Error loading user', e);
      return null;
    }
  }

  Future<void> save(UserData value) async {
    try {
      await localStorage.write(LocalStorageKey.user, jsonEncode(value.toJson()));
    } catch (e) {
      _log.severe('Error saving user', e);
      rethrow;
    }
  }

  Future<void> delete() async {
    try {
      await localStorage.delete(LocalStorageKey.user);
    } catch (e) {
      _log.severe('Error deleting user', e);
      rethrow;
    }
  }
}
