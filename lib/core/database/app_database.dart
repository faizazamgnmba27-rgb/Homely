import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'tables/inventory_tables.dart';
import 'tables/shopping_tables.dart';
import 'tables/bills_tables.dart';
import 'tables/assets_tables.dart';
import 'tables/vehicles_tables.dart';
import 'tables/reminders_tables.dart';
import 'tables/expenses_tables.dart';
import 'tables/documents_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  InventoryCategories,
  InventoryItems,
  ShoppingItems,
  Bills,
  BillPayments,
  Assets,
  AssetServices,
  Vehicles,
  VehicleLogs,
  Reminders,
  Expenses,
  Budgets,
  Documents,
  AppSettingsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed standard default inventory categories
          final uuid = const Uuid();
          final defaultCategories = [
            'Groceries',
            'Fruits & Vegetables',
            'Dairy',
            'Beverages',
            'Snacks',
            'Cleaning Supplies',
            'Toiletries',
            'Kitchen Essentials',
            'Medicines',
            'Others',
          ];

          for (int i = 0; i < defaultCategories.length; i++) {
            await into(inventoryCategories).insert(
              InventoryCategoriesCompanion.insert(
                id: 'cat_${i + 1}',
                name: defaultCategories[i],
                sortOrder: Value(i),
              ),
            );
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'homely.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
