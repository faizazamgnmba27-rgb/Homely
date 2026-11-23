import 'package:drift/drift.dart';

class Vehicles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get registrationNumber => text().withLength(min: 1, max: 50)();
  TextColumn get vehicleType => text()(); // 'car', 'motorcycle', 'scooter', 'other'
  TextColumn get brand => text()();
  TextColumn get model => text()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  IntColumn get currentOdometerKm => integer().withDefault(const Constant(0))();
  DateTimeColumn get insuranceExpiry => dateTime()();
  DateTimeColumn get pucExpiry => dateTime()();
  DateTimeColumn get registrationExpiry => dateTime().nullable()();
  DateTimeColumn get lastServiceDate => dateTime().nullable()();
  DateTimeColumn get nextServiceDate => dateTime().nullable()();
  IntColumn get nextServiceOdometerKm => integer().nullable()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class VehicleLogs extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  TextColumn get logType => text()(); // 'fuel', 'service', 'puc_renewal', 'insurance_renewal', 'repair'
  DateTimeColumn get date => dateTime()();
  IntColumn get odometerKm => integer().nullable()();
  IntColumn get costPaise => integer()();
  RealColumn get fuelLitres => real().nullable()();
  TextColumn get serviceCentre => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get receiptAttachmentPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
