import 'package:drift/drift.dart';

class ShoppingItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get category => text()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  TextColumn get unit => text().withDefault(const Constant('pcs'))();
  IntColumn get expectedPricePaise => integer().nullable()();
  TextColumn get priority => text().withDefault(const Constant('medium'))(); // 'high', 'medium', 'low'
  DateTimeColumn get plannedPurchaseDate => dateTime()();
  DateTimeColumn get reminderDateTime => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('planned'))(); // 'planned', 'purchased', 'postponed', 'cancelled'
  BoolColumn get isConvertedToInventory => boolean().withDefault(const Constant(false))();
  TextColumn get convertedInventoryItemId => text().nullable()();
  DateTimeColumn get purchasedDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
