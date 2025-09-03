import 'package:drift/drift.dart';

import '../configuration/base_table.dart';

class LocationTable extends Table with BaseTableMixin {
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  TextColumn get zip => text()();
  TextColumn get country => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  BoolColumn get isFavorite => boolean().clientDefault(() => false)();
}
