import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:salsa_challenge/app/database/app_database.dart';

abstract class LocationsLocalDataSource {
  Future<void> saveLocation({required String name});
  Future<List<String>> getLocations();
  Future<String?> getLocation(String id);
}

typedef LocationManager = $$LocationTableTableTableManager;

class LocationsLocalDataSourceImpl extends LocationsLocalDataSource {
  final _log = Logger('LocationsLocalDataSourceImpl');

  @visibleForTesting
  final LocationManager manager;

  LocationsLocalDataSourceImpl({required this.manager});

  @override
  Future<String?> getLocation(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getLocations() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveLocation({required String name}) {
    throw UnimplementedError();
  }
}
