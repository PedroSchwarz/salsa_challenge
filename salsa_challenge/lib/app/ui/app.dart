import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:settings/settings.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final store = getIt<SettingsStore>();

  @override
  void initState() {
    super.initState();
    store.loadThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp.router(
          title: 'Salsa Challenge',
          themeMode: switch (store.themeMode) {
            ThemeBrightnessMode.light => ThemeMode.light,
            ThemeBrightnessMode.dark => ThemeMode.dark,
            ThemeBrightnessMode.system => ThemeMode.system,
          },
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: getIt<GoRouter>(),
        );
      },
    );
  }
}
