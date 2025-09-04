import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:home/home.dart';
import 'package:home/ui/views/components/home_content_filters.dart';
import 'package:home/ui/views/components/home_empty_content.dart';
import 'package:home/ui/views/components/home_loading_content.dart';
import 'package:home/ui/views/components/location_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.onLocationSelected, required this.onNavigatedToSettings, super.key});

  final Function(LocationData) onLocationSelected;
  final Function() onNavigatedToSettings;

  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final store = getIt<HomeStore>();
  final scrollController = ScrollController();

  @override
  void initState() {
    store.load();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [IconButton(onPressed: widget.onNavigatedToSettings, icon: const Icon(Icons.settings))],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, AppSpacing.xs),
          child: Observer(
            builder: (context) {
              if (store.isLoading || store.isRefreshing) {
                return const LinearProgressIndicator();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      body: Observer(
        builder: (context) {
          final hasItems = store.showFavoritesOnly ? store.hasFavoriteItems : store.hasItems;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Observer(
                  builder: (context) {
                    return HomeContentFilters(
                      showFavoritesOnly: store.showFavoritesOnly,
                      onFilterChanged: (selected) {
                        _scrollToTop();
                        store.toggleShowFavoritesOnly();
                      },
                    );
                  },
                ),
              ),
              if (store.isLoading)
                Expanded(child: HomeLoadingContent())
              else if (!hasItems)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: HomeEmptyContent(showFavoritesOnly: store.showFavoritesOnly, onRefresh: store.refresh),
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: store.refresh,
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.only(top: AppSpacing.sm, left: AppSpacing.sm, right: AppSpacing.sm, bottom: AppSpacing.xxxl),
                      itemCount: store.filteredItemCount,
                      itemBuilder: (context, index) {
                        return LocationItem(
                          item: store.filteredItems[index],
                          onLocationSelected: widget.onLocationSelected,
                          actionIcon: Observer(
                            builder: (context) {
                              final item = store.filteredItems[index];
                              return IconButton.filledTonal(
                                onPressed: () {
                                  store.toggleFavorite(id: item.id, isFavorite: !item.isFavorite);
                                },
                                icon: store.filteredItems[index].isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(AppSpacing.md);
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
