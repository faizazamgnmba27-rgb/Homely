import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return InventoryRepository(db);
});

class InventoryRepository {
  final AppDatabase _db;

  InventoryRepository(this._db);

  Stream<List<InventoryCategory>> watchCategories() {
    return (_db.select(_db.inventoryCategories)
          ..orderBy([(c) => OrderingTerm(expression: c.sortOrder)]))
        .watch();
  }

  Future<List<InventoryCategory>> getCategories() {
    return (_db.select(_db.inventoryCategories)
          ..orderBy([(c) => OrderingTerm(expression: c.sortOrder)]))
        .get();
  }

  Stream<List<InventoryItem>> watchAllItems({bool includeConsumed = false}) {
    final query = _db.select(_db.inventoryItems);
    if (!includeConsumed) {
      query.where((tbl) => tbl.isConsumed.equals(false));
    }
    query.orderBy([
      (i) => OrderingTerm(expression: i.expiryDate, mode: OrderingMode.asc),
      (i) => OrderingTerm(expression: i.name, mode: OrderingMode.asc),
    ]);
    return query.watch();
  }

  Stream<List<InventoryItem>> watchCategoryItems(String categoryId) {
    return (_db.select(_db.inventoryItems)
          ..where((i) => i.categoryId.equals(categoryId) & i.isConsumed.equals(false))
          ..orderBy([(i) => OrderingTerm(expression: i.expiryDate)]))
        .watch();
  }

  Stream<List<InventoryItem>> watchLowStockItems() {
    return (_db.select(_db.inventoryItems)
          ..where((i) => i.quantity.isSmallerOrEqual(i.minStockThreshold) & i.isConsumed.equals(false)))
        .watch();
  }

  Stream<List<InventoryItem>> watchExpiringSoonItems({int withinDays = 7}) {
    final thresholdDate = DateTime.now().add(Duration(days: withinDays));
    return (_db.select(_db.inventoryItems)
          ..where((i) =>
              i.expiryDate.isBiggerOrEqualValue(DateTime.now()) &
              i.expiryDate.isSmallerOrEqualValue(thresholdDate) &
              i.isConsumed.equals(false))
          ..orderBy([(i) => OrderingTerm(expression: i.expiryDate)]))
        .watch();
  }

  Future<int> insertItem(InventoryItemsCompanion item) {
    return _db.into(_db.inventoryItems).insert(item);
  }

  Future<bool> updateItem(InventoryItemsCompanion item) {
    return _db.update(_db.inventoryItems).replace(item);
  }

  Future<int> deleteItem(String id) {
    return (_db.delete(_db.inventoryItems)..where((i) => i.id.equals(id))).go();
  }

  Future<void> adjustQuantity(String id, double delta) async {
    final item = await (_db.select(_db.inventoryItems)..where((i) => i.id.equals(id))).getSingleOrNull();
    if (item == null) return;
    final newQty = (item.quantity + delta).clamp(0.0, 99999.0);
    await (_db.update(_db.inventoryItems)..where((i) => i.id.equals(id))).write(
      InventoryItemsCompanion(
        quantity: Value(newQty),
        isConsumed: Value(newQty <= 0),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markConsumed(String id) async {
    await (_db.update(_db.inventoryItems)..where((i) => i.id.equals(id))).write(
      InventoryItemsCompanion(
        isConsumed: const Value(true),
        quantity: const Value(0.0),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
