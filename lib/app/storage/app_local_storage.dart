import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  const AppLocalStorage({required this.secureStorage, required this.sharedPreferences});

  @visibleForTesting
  final FlutterSecureStorage secureStorage;

  @visibleForTesting
  final SharedPreferences sharedPreferences;

  Future<void> create() async {
    /// Creates the secure storage and shared preferences if they do not exist.
    final isFirstRun = sharedPreferences.getBool('isFirstRun') ?? true;

    /// Deletes the secure storage and shared preferences if the app is being run for the first time.
    if (isFirstRun) {
      await secureStorage.deleteAll();
      await sharedPreferences.setBool('isFirstRun', false);
    }
  }

  Future<void> write(Enum key, String value) async {
    await secureStorage.write(key: key.name, value: value);
  }

  Future<String?> read(Enum key) async {
    return secureStorage.read(key: key.name);
  }

  Future<void> delete(Enum key) async {
    await secureStorage.delete(key: key.name);
  }
}

enum LocalStorageKey { credentials, user }
