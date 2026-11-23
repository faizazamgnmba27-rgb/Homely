import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final vehiclesRepositoryProvider = Provider<VehiclesRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return VehiclesRepository(db);
});

class VehiclesRepository {
  final AppDatabase _db;

  VehiclesRepository(this._db);

  Stream<List<Vehicle>> watchAllVehicles() {
    return (_db.select(_db.vehicles)..orderBy([(v) => OrderingTerm(expression: v.name)])).watch();
  }

  Stream<Vehicle?> watchVehicleById(String id) {
    return (_db.select(_db.vehicles)..where((v) => v.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<VehicleLog>> watchLogsForVehicle(String vehicleId) {
    return (_db.select(_db.vehicleLogs)
          ..where((l) => l.vehicleId.equals(vehicleId))
          ..orderBy([(l) => OrderingTerm(expression: l.date, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> insertVehicle(VehiclesCompanion vehicle) {
    return _db.into(_db.vehicles).insert(vehicle);
  }

  Future<bool> updateVehicle(VehiclesCompanion vehicle) {
    return _db.update(_db.vehicles).replace(vehicle);
  }

  Future<int> deleteVehicle(String id) {
    return (_db.delete(_db.vehicles)..where((v) => v.id.equals(id))).go();
  }

  Future<void> updateOdometer(String vehicleId, int newKm) async {
    await (_db.update(_db.vehicles)..where((v) => v.id.equals(vehicleId))).write(
      VehiclesCompanion(
        currentOdometerKm: Value(newKm),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> insertLog(VehicleLogsCompanion log) async {
    await _db.transaction(() async {
      await _db.into(_db.vehicleLogs).insert(log);

      // If odometer was logged and higher than current, update vehicle current odometer
      if (log.odometerKm.present && log.odometerKm.value != null) {
        final v = await (_db.select(_db.vehicles)..where((v) => v.id.equals(log.vehicleId.value))).getSingleOrNull();
        if (v != null && log.odometerKm.value! > v.currentOdometerKm) {
          await updateOdometer(v.id, log.odometerKm.value!);
        }
      }

      // Log expense if cost > 0
      if (log.costPaise.value > 0) {
        await _db.into(_db.expenses).insert(
              ExpensesCompanion.insert(
                id: const Uuid().v4(),
                title: 'Vehicle ${log.logType.value.toUpperCase()}',
                category: 'vehicle',
                amountPaise: log.costPaise.value,
                date: log.date.value,
                linkedEntityId: Value(log.id.value),
                linkedEntityType: const Value('vehicle_log'),
                createdAt: DateTime.now(),
              ),
            );
      }
    });
  }
}
