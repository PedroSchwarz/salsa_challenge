import 'package:design_system/theming/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeContentFilters extends StatelessWidget {
  const HomeContentFilters({required this.showFavoritesOnly, required this.onFilterChanged, super.key});

  final bool showFavoritesOnly;
  final ValueChanged<bool> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChip(
          showCheckmark: false,
          selected: !showFavoritesOnly,
          onSelected: onFilterChanged,
          label: const Text('All Locations'),
          avatar: const Icon(Icons.home, size: 18),
        ),
        const Gap(AppSpacing.sm),
        FilterChip(
          showCheckmark: false,
          selected: showFavoritesOnly,
          onSelected: onFilterChanged,
          label: const Text('Favorites'),
          avatar: const Icon(Icons.favorite, size: 18),
        ),
      ],
    );
  }
}
