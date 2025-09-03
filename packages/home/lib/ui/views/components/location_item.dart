import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/components/app_skeleton.dart';
import 'package:design_system/theming/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:home/data/models/location_data.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({required this.item, required this.onLocationSelected, this.actionIcon, super.key});

  final LocationData item;
  final Function(LocationData) onLocationSelected;
  final Widget? actionIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      key: ValueKey(item.id),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => {onLocationSelected(item)},
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.fill,
                  height: 250,
                  width: double.infinity,
                  placeholder: (_, __) => const AppSkeleton(isLoading: true, child: SizedBox(height: 250, width: double.infinity)),
                  errorWidget: (_, __, ___) => const AppSkeleton(isLoading: true, child: SizedBox(height: 300, width: double.infinity)),
                ),
                if (actionIcon != null) Positioned(right: AppSpacing.md, bottom: AppSpacing.md, child: actionIcon!),
              ],
            ),
            ListTile(
              title: Text(item.name, style: theme.textTheme.titleLarge?.copyWith(letterSpacing: 1.5)),
              subtitle: Text(item.description, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSecondaryContainer)),
            ),
          ],
        ),
      ),
    );
  }
}
