import 'package:flutter/foundation.dart';
import 'package:home/data/models/location_data.dart';
import 'package:home/data/repositories/home_repository.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'location_details_store.g.dart';

// ignore: library_private_types_in_public_api
class LocationDetailsStore = _LocationDetailsStore with _$LocationDetailsStore;

abstract class _LocationDetailsStore with Store {
  _LocationDetailsStore({required this.homeRepository});

  @visibleForTesting
  final HomeRepository homeRepository;

  final _log = Logger('LocationDetailsStore');

  @readonly
  bool _isLoading = false;

  @readonly
  bool _isRefreshing = false;

  @readonly
  LocationData? _location;

  @readonly
  bool _isAppBarCollapsed = false;

  @computed
  bool get hasLocation => _location != null;

  @action
  void setAppBarCollapsed(bool collapsed) {
    _isAppBarCollapsed = collapsed;
  }

  @action
  Future<void> load({required int id}) async {
    _isLoading = true;
    try {
      await _loadLocation(id: id);
    } catch (e) {
      _log.severe('Error loading location', e);
    } finally {
      _isLoading = false;
    }
  }

  @action
  Future<void> refresh({required int id}) async {
    _isRefreshing = true;
    try {
      await _loadLocation(id: id);
    } catch (e) {
      _log.severe('Error refreshing location', e);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _loadLocation({required int id}) async {
    await homeRepository.init();
    final location = await homeRepository.getLocation(id: id);
    _location = location;
  }
}
