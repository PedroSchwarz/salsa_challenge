import 'package:auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';
import 'package:settings/data/data_source/local/settings_local_data_source.dart';
import 'package:settings/data/repositories/settings_repository.dart';

part 'settings_store.g.dart';

// ignore: library_private_types_in_public_api
class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  _SettingsStore({required this.settingsRepository, required this.authRepository});

  @visibleForTesting
  final SettingsRepository settingsRepository;

  @visibleForTesting
  final AuthRepository authRepository;

  final _log = Logger('SettingsStore');

  @readonly
  bool _isLoading = false;

  @readonly
  ThemeBrightnessMode _themeMode = ThemeBrightnessMode.system;

  @readonly
  UserData? _user;

  @computed
  String get fullName => '${_user?.firstName} ${_user?.lastName}';

  @computed
  String get nameInitials => '${_user?.firstName.substring(0, 1)}${_user?.lastName.substring(0, 1)}';

  @action
  Future<void> load() async {
    _isLoading = true;
    try {
      await Future.wait([_loadUser(), loadThemeMode()]);
    } catch (e) {
      _log.severe('Error loading settings', e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _loadUser() async {
    _user = authRepository.currentUser.value;
  }

  @action
  Future<void> loadThemeMode() async {
    _themeMode = await settingsRepository.getThemeMode();
  }

  @action
  Future<void> saveThemeMode(ThemeBrightnessMode themeMode) async {
    await settingsRepository.saveThemeMode(themeMode);
    _themeMode = themeMode;
  }

  @action
  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
