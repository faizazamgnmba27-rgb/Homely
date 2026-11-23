import 'package:drift/drift.dart';

class Assets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get category => text()(); // 'refrigerator', 'washing_machine', 'ac', 'tv', 'microwave', 'water_purifier', 'inverter', 'laptop', 'smartphone', 'other'
  TextColumn get brand => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get serialNumber => text().nullable()();
  DateTimeColumn get purchaseDate => dateTime()();
  IntColumn get purchasePricePaise => integer().nullable()();
  DateTimeColumn get warrantyStartDate => dateTime().nullable()();
  DateTimeColumn get warrantyExpiryDate => dateTime()();
  TextColumn get seller => text().nullable()();
  TextColumn get invoiceAttachmentPath => text().nullable()();
  TextColumn get warrantyDocPath => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  IntColumn get serviceIntervalMonths => integer().nullable()();
  DateTimeColumn get lastServiceDate => dateTime().nullable()();
  DateTimeColumn get nextServiceDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AssetServices extends Table {
  TextColumn get id => text()();
  TextColumn get assetId => text().references(Assets, #id)();
  DateTimeColumn get serviceDate => dateTime()();
  TextColumn get serviceType => text()(); // 'routine', 'repair', 'filter_change', 'inspection'
  TextColumn get technicianName => text().nullable()();
  TextColumn get technicianContact => text().nullable()();
  IntColumn get costPaise => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  TextColumn get receiptAttachmentPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
