import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:home/ui/stores/location_details_store.dart';
import 'package:home/ui/views/components/location_map_view.dart';

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({required this.id, super.key});

  final int id;

  static const routeName = 'details';

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  final store = getIt<LocationDetailsStore>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    store.load(id: widget.id);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset > 260;

    if (isCollapsed != store.isAppBarCollapsed) {
      store.setAppBarCollapsed(isCollapsed);
    }
  }

  void _expandAppBar() {
    store.setAppBarCollapsed(false);
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          final theme = Theme.of(context);
          final location = store.location;

          if (store.isLoading) {
            return Column(
              children: [
                const AppSkeleton(isLoading: true, child: SizedBox(height: 250, width: double.infinity)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: ListView.separated(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const AppSkeleton(isLoading: true, child: SizedBox(height: 100, width: double.infinity));
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(AppSpacing.md);
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          if (location == null) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Center(
                child: Column(
                  spacing: AppSpacing.md,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No locations found. Try again later.', style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
                    IconButton.filled(
                      onPressed: () => store.refresh(id: widget.id),
                      icon: const Icon(Icons.refresh),
                      iconSize: 32,
                      tooltip: 'Refresh location data',
                    ),
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
            physics: store.isAppBarCollapsed ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar.large(
                expandedHeight: 250,
                pinned: true,
                stretch: true,
                title: Text(location.name),
                actions: [
                  if (store.isAppBarCollapsed) IconButton.filledTonal(onPressed: _expandAppBar, icon: const Icon(Icons.close), tooltip: 'Close Map'),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(location.name, style: theme.textTheme.titleLarge?.copyWith(letterSpacing: 1.5, color: theme.colorScheme.onPrimary)),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.all(AppSpacing.md),
                  background: CachedNetworkImage(
                    imageUrl: location.imageUrl,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    placeholder: (_, __) => const AppSkeleton(isLoading: true, child: SizedBox(height: 250, width: double.infinity)),
                    errorWidget: (_, __, ___) => const AppSkeleton(isLoading: true, child: SizedBox(height: 250, width: double.infinity)),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location.description, style: theme.textTheme.bodyLarge),
                      const Gap(AppSpacing.sm),
                      Text('${location.address}, ${location.city}', style: theme.textTheme.bodyMedium),
                      const Gap(AppSpacing.sm),
                      Divider(),
                      const Gap(AppSpacing.sm),
                      Text('Check it out on Google Maps', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                fillOverscroll: true,
                child: LocationMapView(latitude: location.latitude, longitude: location.longitude),
              ),
            ],
          );
        },
      ),
    );
  }
}
