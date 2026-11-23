import 'package:drift/drift.dart';

class Bills extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get category => text()(); // 'electricity', 'wifi', 'water', 'lpg', 'mobile', 'rent', 'maintenance', 'ott', 'insurance', 'other'
  TextColumn get provider => text()();
  IntColumn get expectedAmountPaise => integer()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get recurrence => text().withDefault(const Constant('monthly'))(); // 'one_time', 'weekly', 'monthly', 'quarterly', 'yearly'
  IntColumn get reminderDaysBefore => integer().withDefault(const Constant(3))();
  TextColumn get status => text().withDefault(const Constant('upcoming'))(); // 'upcoming', 'paid', 'overdue'
  TextColumn get notes => text().nullable()();
  TextColumn get attachmentPath => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BillPayments extends Table {
  TextColumn get id => text()();
  TextColumn get billId => text().references(Bills, #id)();
  IntColumn get paidAmountPaise => integer()();
  DateTimeColumn get paymentDate => dateTime()();
  TextColumn get paymentMethod => text().withDefault(const Constant('UPI'))(); // 'UPI', 'NetBanking', 'Card', 'Cash'
  TextColumn get receiptAttachmentPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
