import 'package:flutter/foundation.dart';
import 'package:home/data/data_sources/local/home_local_data_source.dart';
import 'package:home/data/mocks/locations_mock.dart';
import 'package:home/data/models/location_data.dart';
import 'package:logging/logging.dart';

class HomeRepository {
  HomeRepository({required this.homeLocalDataSource});

  @visibleForTesting
  final HomeLocalDataSource homeLocalDataSource;

  final _log = Logger('HomeRepository');

  Future<void> init() async {
    try {
      final locations = await homeLocalDataSource.getLocations();

      if (locations.isEmpty) {
        await homeLocalDataSource.saveLocations(locationsMock);
      }
    } catch (e) {
      _log.severe('Error initializing home repository', e);
      rethrow;
    }
  }

  Future<List<LocationData>> getLocations() async {
    return await homeLocalDataSource.getLocations();
  }

  Future<LocationData> getLocation({required int id}) async {
    return await homeLocalDataSource.getLocation(id: id);
  }

  Future<void> updateLocation({required int id, required bool isFavorite}) async {
    return await homeLocalDataSource.updateLocation(id: id, isFavorite: isFavorite);
  }
}
