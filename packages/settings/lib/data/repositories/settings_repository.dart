import 'package:flutter/foundation.dart';
import 'package:settings/data/data_source/local/settings_local_data_source.dart';

class SettingsRepository {
  SettingsRepository({required this.settingsLocalDataSource});

  @visibleForTesting
  final SettingsLocalDataSource settingsLocalDataSource;

  Future<ThemeBrightnessMode> getThemeMode() async {
    return await settingsLocalDataSource.getThemeMode();
  }

  Future<void> saveThemeMode(ThemeBrightnessMode themeMode) async {
    await settingsLocalDataSource.saveThemeMode(themeMode);
  }
}
