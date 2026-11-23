import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final assetsRepositoryProvider = Provider<AssetsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AssetsRepository(db);
});

class AssetsRepository {
  final AppDatabase _db;

  AssetsRepository(this._db);

  Stream<List<Asset>> watchAllAssets() {
    return (_db.select(_db.assets)
          ..orderBy([(a) => OrderingTerm(expression: a.warrantyExpiryDate)]))
        .watch();
  }

  Stream<Asset?> watchAssetById(String id) {
    return (_db.select(_db.assets)..where((a) => a.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<AssetService>> watchServicesForAsset(String assetId) {
    return (_db.select(_db.assetServices)
          ..where((s) => s.assetId.equals(assetId))
          ..orderBy([(s) => OrderingTerm(expression: s.serviceDate, mode: OrderingMode.desc)]))
        .watch();
  }

  Stream<List<Asset>> watchExpiringWarranties({int withinDays = 30}) {
    final threshold = DateTime.now().add(Duration(days: withinDays));
    return (_db.select(_db.assets)
          ..where((a) =>
              a.warrantyExpiryDate.isBiggerOrEqualValue(DateTime.now()) &
              a.warrantyExpiryDate.isSmallerOrEqualValue(threshold))
          ..orderBy([(a) => OrderingTerm(expression: a.warrantyExpiryDate)]))
        .watch();
  }

  Stream<List<Asset>> watchUpcomingServices({int withinDays = 30}) {
    final threshold = DateTime.now().add(Duration(days: withinDays));
    return (_db.select(_db.assets)
          ..where((a) =>
              a.nextServiceDate.isNotNull() &
              a.nextServiceDate.isBiggerOrEqualValue(DateTime.now()) &
              a.nextServiceDate.isSmallerOrEqualValue(threshold))
          ..orderBy([(a) => OrderingTerm(expression: a.nextServiceDate)]))
        .watch();
  }

  Future<int> insertAsset(AssetsCompanion asset) {
    return _db.into(_db.assets).insert(asset);
  }

  Future<bool> updateAsset(AssetsCompanion asset) {
    return _db.update(_db.assets).replace(asset);
  }

  Future<int> deleteAsset(String id) {
    return (_db.delete(_db.assets)..where((a) => a.id.equals(id))).go();
  }

  Future<int> insertService(AssetServicesCompanion service) {
    return _db.into(_db.assetServices).insert(service);
  }
}
