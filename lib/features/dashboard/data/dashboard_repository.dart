import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DashboardRepository(db);
});

class DashboardMetrics {
  final int currentMonthSpendingPaise;
  final int upcomingBillsCount;
  final int upcomingBillsTotalPaise;
  final int lowStockCount;
  final int expiringWarrantiesCount;
  final int upcomingPurchasesCount;
  final int expiringFoodCount;
  final List<Bill> upcomingBills;
  final List<InventoryItem> lowStockItems;
  final List<InventoryItem> expiringFoodItems;
  final List<Asset> expiringAssets;
  final List<ShoppingItem> upcomingPurchases;

  DashboardMetrics({
    required this.currentMonthSpendingPaise,
    required this.upcomingBillsCount,
    required this.upcomingBillsTotalPaise,
    required this.lowStockCount,
    required this.expiringWarrantiesCount,
    required this.upcomingPurchasesCount,
    required this.expiringFoodCount,
    required this.upcomingBills,
    required this.lowStockItems,
    required this.expiringFoodItems,
    required this.expiringAssets,
    required this.upcomingPurchases,
  });
}

class DashboardRepository {
  final AppDatabase _db;

  DashboardRepository(this._db);

  Stream<DashboardMetrics> watchDashboardMetrics() async* {
    // Listen to changes in expenses, bills, inventory, assets, shopping
    yield* _db.select(_db.expenses).watch().asyncMap((_) async {
      return getDashboardMetrics();
    });
  }

  Future<DashboardMetrics> getDashboardMetrics() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 1);

    // 1. Current Month Expenses
    final expenses = await (_db.select(_db.expenses)
          ..where((e) => e.date.isBiggerOrEqualValue(startOfMonth) & e.date.isSmallerThanValue(endOfMonth)))
        .get();
    final monthlySpending = expenses.fold<int>(0, (sum, e) => sum + e.amountPaise);

    // 2. Upcoming Bills
    final bills = await (_db.select(_db.bills)
          ..where((b) => b.isArchived.equals(false) & b.status.equals('upcoming'))
          ..orderBy([(b) => OrderingTerm(expression: b.dueDate)]))
        .get();
    final upcomingBillsTotal = bills.fold<int>(0, (sum, b) => sum + b.expectedAmountPaise);

    // 3. Low Stock Items
    final lowStock = await (_db.select(_db.inventoryItems)
          ..where((i) => i.quantity.isSmallerOrEqual(i.minStockThreshold) & i.isConsumed.equals(false)))
        .get();

    // 4. Near Expiry Food (within 15 days)
    final fifteenDaysLater = now.add(const Duration(days: 15));
    final expiringFood = await (_db.select(_db.inventoryItems)
          ..where((i) =>
              i.expiryDate.isNotNull() &
              i.expiryDate.isBiggerOrEqualValue(now) &
              i.expiryDate.isSmallerOrEqualValue(fifteenDaysLater) &
              i.isConsumed.equals(false))
          ..orderBy([(i) => OrderingTerm(expression: i.expiryDate)]))
        .get();

    // 5. Expiring Warranties (within 45 days)
    final warrantyThreshold = now.add(const Duration(days: 45));
    final expiringAssets = await (_db.select(_db.assets)
          ..where((a) =>
              a.warrantyExpiryDate.isBiggerOrEqualValue(now) &
              a.warrantyExpiryDate.isSmallerOrEqualValue(warrantyThreshold)))
        .get();

    // 6. Upcoming Shopping Wishlist items
    final purchases = await (_db.select(_db.shoppingItems)
          ..where((s) => s.status.equals('planned'))
          ..orderBy([(s) => OrderingTerm(expression: s.plannedPurchaseDate)]))
        .get();

    return DashboardMetrics(
      currentMonthSpendingPaise: monthlySpending,
      upcomingBillsCount: bills.length,
      upcomingBillsTotalPaise: upcomingBillsTotal,
      lowStockCount: lowStock.length,
      expiringWarrantiesCount: expiringAssets.length,
      upcomingPurchasesCount: purchases.length,
      expiringFoodCount: expiringFood.length,
      upcomingBills: bills.take(3).toList(),
      lowStockItems: lowStock.take(3).toList(),
      expiringFoodItems: expiringFood,
      expiringAssets: expiringAssets.take(3).toList(),
      upcomingPurchases: purchases.take(3).toList(),
    );
  }
}
