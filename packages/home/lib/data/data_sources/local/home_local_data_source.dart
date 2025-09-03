import 'package:database/configuration/app_database.dart';
import 'package:flutter/foundation.dart';
import 'package:home/data/models/location_data.dart';
import 'package:logging/logging.dart';

abstract class HomeLocalDataSource {
  Future<void> saveLocation(LocationData location);
  Future<void> saveLocations(List<LocationData> locations);
  Future<List<LocationData>> getLocations();
  Future<List<LocationData>> geFavoritesLocations();
  Future<void> updateLocation({required int id, required bool isFavorite});
  Future<LocationData> getLocation({required int id});
  Future<void> deleteLocation({required int id});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({required this.locationManager});

  @visibleForTesting
  final LocationManager locationManager;

  final _log = Logger('HomeLocalDataSourceImpl');

  @override
  Future<void> saveLocation(LocationData location) async {
    try {
      await locationManager.create((o) {
        return o(
          name: location.name,
          description: location.description,
          imageUrl: location.imageUrl,
          address: location.address,
          city: location.city,
          state: location.state,
          zip: location.zip,
          country: location.country,
          latitude: location.latitude,
          longitude: location.longitude,
        );
      });
    } catch (e) {
      _log.severe('Error saving location', e);
      rethrow;
    }
  }

  @override
  Future<void> saveLocations(List<LocationData> locations) async {
    try {
      await locationManager.bulkCreate((o) {
        return locations.map(
          (location) => o(
            name: location.name,
            description: location.description,
            imageUrl: location.imageUrl,
            address: location.address,
            city: location.city,
            state: location.state,
            zip: location.zip,
            country: location.country,
            latitude: location.latitude,
            longitude: location.longitude,
          ),
        );
      });
    } catch (e) {
      _log.severe('Error saving locations', e);
      rethrow;
    }
  }

  @override
  Future<List<LocationData>> getLocations() async {
    try {
      final entities = await locationManager.get();
      return entities.map((entity) => LocationData.fromJson(entity.toJson())).toList();
    } catch (e) {
      _log.severe('Error getting locations', e);
      rethrow;
    }
  }

  @override
  Future<List<LocationData>> geFavoritesLocations() async {
    try {
      final entities = await locationManager.filter((filter) => filter.isFavorite(true)).get();
      return entities.map((entity) => LocationData.fromJson(entity.toJson())).toList();
    } catch (e) {
      _log.severe('Error getting locations', e);
      rethrow;
    }
  }

  @override
  Future<void> updateLocation({required int id, required bool isFavorite}) async {
    try {
      var entity = await locationManager.filter((filter) => filter.id(id)).getSingle();
      entity = entity.copyWith(isFavorite: isFavorite);
      await locationManager.replace(entity);
    } catch (e) {
      _log.severe('Error updating location', e);
      rethrow;
    }
  }

  @override
  Future<LocationData> getLocation({required int id}) async {
    try {
      final entity = await locationManager.filter((filter) => filter.id(id)).getSingle();
      return LocationData.fromJson(entity.toJson());
    } catch (e) {
      _log.severe('Error getting location', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteLocation({required int id}) async {
    try {
      await locationManager.filter((filter) => filter.id(id)).delete();
    } catch (e) {
      _log.severe('Error deleting location', e);
      rethrow;
    }
  }
}
