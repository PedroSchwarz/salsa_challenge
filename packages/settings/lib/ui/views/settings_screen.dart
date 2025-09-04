import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:settings/data/data_source/local/settings_local_data_source.dart';
import 'package:settings/ui/stores/settings_store.dart';
import 'package:design_system/design_system.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = 'settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final store = getIt<SettingsStore>();

  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Observer(
                        builder: (context) {
                          final user = store.user;

                          if (store.isLoading || user == null) {
                            return const AppSkeleton(isLoading: true, child: SizedBox(height: 48, width: double.infinity));
                          }

                          return Row(
                            spacing: AppSpacing.md,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(radius: 32, child: Text(store.nameInitials, style: theme.textTheme.titleLarge)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.fullName,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Text(user.email, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSecondaryContainer)),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      const Gap(AppSpacing.md),
                      const Divider(),
                      const Gap(AppSpacing.md),
                      Text('Change Theme Mode', style: theme.textTheme.bodyLarge),
                      const Gap(AppSpacing.md),
                      Observer(
                        builder: (context) {
                          return SegmentedButton<ThemeBrightnessMode>(
                            segments:
                                ThemeBrightnessMode.values.map((mode) => ButtonSegment(value: mode, label: Text(mode.name.toUpperCase()))).toList(),
                            selected: {store.themeMode},
                            onSelectionChanged: (value) {
                              store.saveThemeMode(value.first);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              const Divider(),
              const Gap(AppSpacing.md),
              FilledButton(onPressed: store.signOut, child: const Text('Sign out')),
            ],
          ),
        ),
      ),
    );
  }
}
