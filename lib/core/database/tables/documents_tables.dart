import 'package:drift/drift.dart';

class Documents extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 250)();
  TextColumn get category => text()(); // 'invoice', 'warranty_card', 'insurance', 'vehicle_doc', 'service_receipt', 'bill', 'other'
  TextColumn get localFilePath => text()();
  IntColumn get fileSizeBytes => integer().nullable()();
  TextColumn get mimeType => text().nullable()();
  TextColumn get linkedEntityType => text().nullable()(); // 'asset', 'vehicle', 'bill', 'none'
  TextColumn get linkedEntityId => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AppSettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}
