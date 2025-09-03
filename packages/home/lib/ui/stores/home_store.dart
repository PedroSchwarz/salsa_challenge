import 'package:flutter/foundation.dart';
import 'package:home/data/models/location_data.dart';
import 'package:home/data/repositories/home_repository.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore({required this.homeRepository});

  @visibleForTesting
  final HomeRepository homeRepository;

  final _log = Logger('HomeStore');

  @readonly
  bool _isLoading = false;

  @readonly
  bool _isRefreshing = false;

  @readonly
  ObservableList<LocationData> _items = ObservableList.of([]);

  @readonly
  bool _showFavoritesOnly = false;

  @computed
  bool get hasItems => _items.isNotEmpty;

  @computed
  int get itemCount => _items.length;

  @computed
  ObservableList<LocationData> get favoriteItems => ObservableList.of(_items.where((item) => item.isFavorite).toList());

  @computed
  bool get hasFavoriteItems => favoriteItems.isNotEmpty;

  @computed
  ObservableList<LocationData> get filteredItems => _showFavoritesOnly ? favoriteItems : _items;

  @computed
  int get filteredItemCount => filteredItems.length;

  @action
  Future<void> load() async {
    _isLoading = true;
    try {
      await _loadLocations();
    } catch (e) {
      _log.severe('Error loading items', e);
    } finally {
      _isLoading = false;
    }
  }

  @action
  Future<void> toggleFavorite({required int id, required bool isFavorite}) async {
    try {
      await homeRepository.updateLocation(id: id, isFavorite: isFavorite);

      final index = _items.indexWhere((element) => element.id == id);

      if (index != -1) {
        _items[index] = _items[index].copyWith(isFavorite: isFavorite);
      }
    } catch (e) {
      _log.severe('Error toggling favorite', e);
    }
  }

  @action
  void toggleShowFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;
  }

  @action
  Future<void> refresh() async {
    _isRefreshing = true;
    try {
      await _loadLocations();
    } catch (e) {
      _log.severe('Error refreshing items', e);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _loadLocations() async {
    await homeRepository.init();
    final locations = await homeRepository.getLocations();
    _items.clear();
    _items.addAll(locations);
  }
}
