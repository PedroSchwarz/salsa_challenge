import 'package:core/storage/app_local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:collection/collection.dart';

enum ThemeBrightnessMode { light, dark, system }

abstract class SettingsLocalDataSource {
  Future<void> saveThemeMode(ThemeBrightnessMode themeMode);
  Future<ThemeBrightnessMode> getThemeMode();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  final _log = Logger('SettingsLocalDataSourceImpl');

  @override
  Future<void> saveThemeMode(ThemeBrightnessMode themeMode) async {
    try {
      await localStorage.write(LocalStorageKey.themeMode, themeMode.name);
    } catch (e) {
      _log.severe('Error saving theme mode', e);
    }
  }

  @override
  Future<ThemeBrightnessMode> getThemeMode() async {
    try {
      final value = await localStorage.read(LocalStorageKey.themeMode);

      if (value == null) {
        return ThemeBrightnessMode.system;
      }

      return ThemeBrightnessMode.values.firstWhereOrNull((e) => e.name == value) ?? ThemeBrightnessMode.system;
    } catch (e) {
      _log.severe('Error getting theme mode', e);
      return ThemeBrightnessMode.system;
    }
  }
}
