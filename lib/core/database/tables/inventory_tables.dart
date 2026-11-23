import 'package:drift/drift.dart';

class InventoryCategories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get iconName => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get categoryId => text().references(InventoryCategories, #id)();
  TextColumn get brand => text().nullable()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  TextColumn get unit => text().withDefault(const Constant('pcs'))(); // 'kg', 'ltr', 'pcs', 'packets', 'grams'
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  RealColumn get minStockThreshold => real().withDefault(const Constant(1.0))();
  IntColumn get approximatePricePaise => integer().nullable()(); // Integer paise
  TextColumn get storageLocation => text().nullable()(); // 'Pantry', 'Refrigerator', 'Cabinet', etc.
  TextColumn get notes => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  BoolColumn get isConsumed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
