import 'package:design_system/theming/app_spacing.dart';
import 'package:flutter/material.dart';

class HomeEmptyContent extends StatelessWidget {
  const HomeEmptyContent({required this.showFavoritesOnly, required this.onRefresh, super.key});

  final bool showFavoritesOnly;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        spacing: AppSpacing.md,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            showFavoritesOnly ? 'No favorite locations found.' : 'No locations found. Try again later.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          IconButton.filled(onPressed: onRefresh, icon: const Icon(Icons.refresh), iconSize: 32, tooltip: 'Refresh locations list'),
        ],
      ),
    );
  }
}
