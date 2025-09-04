// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<String>? _$fullNameComputed;

  @override
  String get fullName =>
      (_$fullNameComputed ??= Computed<String>(
            () => super.fullName,
            name: '_SettingsStore.fullName',
          ))
          .value;
  Computed<String>? _$nameInitialsComputed;

  @override
  String get nameInitials =>
      (_$nameInitialsComputed ??= Computed<String>(
            () => super.nameInitials,
            name: '_SettingsStore.nameInitials',
          ))
          .value;

  late final _$_isLoadingAtom = Atom(
    name: '_SettingsStore._isLoading',
    context: context,
  );

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_themeModeAtom = Atom(
    name: '_SettingsStore._themeMode',
    context: context,
  );

  ThemeBrightnessMode get themeMode {
    _$_themeModeAtom.reportRead();
    return super._themeMode;
  }

  @override
  ThemeBrightnessMode get _themeMode => themeMode;

  @override
  set _themeMode(ThemeBrightnessMode value) {
    _$_themeModeAtom.reportWrite(value, super._themeMode, () {
      super._themeMode = value;
    });
  }

  late final _$_userAtom = Atom(name: '_SettingsStore._user', context: context);

  UserData? get user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  UserData? get _user => user;

  @override
  set _user(UserData? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_SettingsStore.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$loadThemeModeAsyncAction = AsyncAction(
    '_SettingsStore.loadThemeMode',
    context: context,
  );

  @override
  Future<void> loadThemeMode() {
    return _$loadThemeModeAsyncAction.run(() => super.loadThemeMode());
  }

  late final _$saveThemeModeAsyncAction = AsyncAction(
    '_SettingsStore.saveThemeMode',
    context: context,
  );

  @override
  Future<void> saveThemeMode(ThemeBrightnessMode themeMode) {
    return _$saveThemeModeAsyncAction.run(() => super.saveThemeMode(themeMode));
  }

  late final _$signOutAsyncAction = AsyncAction(
    '_SettingsStore.signOut',
    context: context,
  );

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  @override
  String toString() {
    return '''
fullName: ${fullName},
nameInitials: ${nameInitials}
    ''';
  }
}
