import 'package:drift/drift.dart';

class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 250)();
  TextColumn get eventType => text().withDefault(const Constant('custom'))();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get priority => text().withDefault(const Constant('medium'))(); // 'high', 'medium', 'low'
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get snoozedUntil => dateTime().nullable()();
  TextColumn get relatedEntityId => text().nullable()();
  TextColumn get relatedEntityType => text().nullable()(); // 'bill', 'asset', 'vehicle', 'inventory'
  TextColumn get notes => text().nullable()();
  IntColumn get notificationId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
