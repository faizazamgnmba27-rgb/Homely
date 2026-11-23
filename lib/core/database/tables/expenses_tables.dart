import 'package:drift/drift.dart';

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get category => text()(); // 'grocery', 'utility', 'maintenance', 'vehicle', 'shopping', 'healthcare', 'other'
  IntColumn get amountPaise => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get paymentMethod => text().withDefault(const Constant('UPI'))();
  TextColumn get notes => text().nullable()();
  TextColumn get linkedEntityId => text().nullable()();
  TextColumn get linkedEntityType => text().nullable()(); // 'bill_payment', 'vehicle_log', 'shopping_purchase', 'manual'
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Budgets extends Table {
  TextColumn get id => text()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  IntColumn get monthlyBudgetPaise => integer().withDefault(const Constant(5000000))(); // Default ₹50,000
  TextColumn get categoryAllocationsJson => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
