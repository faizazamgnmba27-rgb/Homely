import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final shoppingRepositoryProvider = Provider<ShoppingRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ShoppingRepository(db);
});

class ShoppingRepository {
  final AppDatabase _db;

  ShoppingRepository(this._db);

  Stream<List<ShoppingItem>> watchAllItems() {
    return (_db.select(_db.shoppingItems)
          ..orderBy([
            (s) => OrderingTerm(expression: s.plannedPurchaseDate, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  Stream<List<ShoppingItem>> watchItemsByBucket(String bucket) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final query = _db.select(_db.shoppingItems);

    switch (bucket) {
      case 'today':
        query.where((s) =>
            s.status.equals('planned') &
            s.plannedPurchaseDate.isBiggerOrEqualValue(todayStart) &
            s.plannedPurchaseDate.isSmallerThanValue(todayEnd));
        break;
      case 'upcoming':
        query.where((s) =>
            s.status.equals('planned') &
            s.plannedPurchaseDate.isBiggerOrEqualValue(todayEnd));
        break;
      case 'later':
        query.where((s) => s.status.equals('postponed'));
        break;
      case 'completed':
        query.where((s) => s.status.equals('purchased'));
        break;
      default:
        break;
    }

    query.orderBy([(s) => OrderingTerm(expression: s.plannedPurchaseDate)]);
    return query.watch();
  }

  Future<int> insertItem(ShoppingItemsCompanion item) {
    return _db.into(_db.shoppingItems).insert(item);
  }

  Future<bool> updateItem(ShoppingItemsCompanion item) {
    return _db.update(_db.shoppingItems).replace(item);
  }

  Future<int> deleteItem(String id) {
    return (_db.delete(_db.shoppingItems)..where((s) => s.id.equals(id))).go();
  }

  Future<void> postponeItem(String id, int addDays) async {
    final item = await (_db.select(_db.shoppingItems)..where((s) => s.id.equals(id))).getSingleOrNull();
    if (item == null) return;
    final newDate = item.plannedPurchaseDate.add(Duration(days: addDays));
    await (_db.update(_db.shoppingItems)..where((s) => s.id.equals(id))).write(
      ShoppingItemsCompanion(
        plannedPurchaseDate: Value(newDate),
        status: const Value('postponed'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Explicitly confirms purchase AND converts item to Inventory while strictly preventing duplicate creation
  Future<String?> markAsPurchasedAndConvertToInventory(String shoppingItemId) async {
    return _db.transaction(() async {
      final shoppingItem = await (_db.select(_db.shoppingItems)
            ..where((s) => s.id.equals(shoppingItemId)))
          .getSingleOrNull();

      if (shoppingItem == null) return null;
      if (shoppingItem.isConvertedToInventory && shoppingItem.convertedInventoryItemId != null) {
        // Prevent duplicate inventory entry
        return shoppingItem.convertedInventoryItemId;
      }

      final newInventoryId = const Uuid().v4();
      final now = DateTime.now();

      // 1. Insert into inventory
      await _db.into(_db.inventoryItems).insert(
            InventoryItemsCompanion.insert(
              id: newInventoryId,
              name: shoppingItem.name,
              categoryId: 'cat_1', // default grocery
              quantity: Value(shoppingItem.quantity),
              unit: Value(shoppingItem.unit),
              purchaseDate: Value(now),
              approximatePricePaise: Value(shoppingItem.expectedPricePaise),
              notes: Value(shoppingItem.notes != null ? 'Purchased via Wishlist: ${shoppingItem.notes}' : 'Purchased via Wishlist'),
              isConsumed: const Value(false),
              createdAt: now,
              updatedAt: now,
            ),
          );

      // 2. Also log as Expense if price was recorded
      if (shoppingItem.expectedPricePaise != null && shoppingItem.expectedPricePaise! > 0) {
        await _db.into(_db.expenses).insert(
              ExpensesCompanion.insert(
                id: const Uuid().v4(),
                title: shoppingItem.name,
                category: 'shopping',
                amountPaise: shoppingItem.expectedPricePaise!,
                date: now,
                paymentMethod: const Value('UPI'),
                linkedEntityId: Value(shoppingItemId),
                linkedEntityType: const Value('shopping_purchase'),
                createdAt: now,
              ),
            );
      }

      // 3. Mark shopping item as purchased and link to inventory item
      await (_db.update(_db.shoppingItems)..where((s) => s.id.equals(shoppingItemId))).write(
        ShoppingItemsCompanion(
          status: const Value('purchased'),
          isConvertedToInventory: const Value(true),
          convertedInventoryItemId: Value(newInventoryId),
          purchasedDate: Value(now),
          updatedAt: Value(now),
        ),
      );

      return newInventoryId;
    });
  }
}
