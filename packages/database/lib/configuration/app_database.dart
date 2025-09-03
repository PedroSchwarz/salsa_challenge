import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:database/tables/location_table.dart';

part 'app_database.g.dart';

typedef LocationManager = $$LocationTableTableTableManager;

@DriftDatabase(tables: [LocationTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'task_master_db');
  }
}
