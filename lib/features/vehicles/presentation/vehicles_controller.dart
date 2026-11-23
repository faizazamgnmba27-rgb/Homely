import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../data/vehicles_repository.dart';

final allVehiclesProvider = StreamProvider<List<Vehicle>>((ref) {
  final repo = ref.watch(vehiclesRepositoryProvider);
  return repo.watchAllVehicles();
});

final vehicleDetailProvider = StreamProvider.family<Vehicle?, String>((ref, id) {
  final repo = ref.watch(vehiclesRepositoryProvider);
  return repo.watchVehicleById(id);
});

final vehicleLogsProvider = StreamProvider.family<List<VehicleLog>, String>((ref, vehicleId) {
  final repo = ref.watch(vehiclesRepositoryProvider);
  return repo.watchLogsForVehicle(vehicleId);
});
