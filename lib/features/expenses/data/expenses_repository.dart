import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final expensesRepositoryProvider = Provider<ExpensesRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExpensesRepository(db);
});

class ExpensesRepository {
  final AppDatabase _db;

  ExpensesRepository(this._db);

  Stream<List<Expense>> watchAllExpenses() {
    return (_db.select(_db.expenses)
          ..orderBy([(e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc)]))
        .watch();
  }

  Stream<List<Expense>> watchExpensesForMonth(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    return (_db.select(_db.expenses)
          ..where((e) => e.date.isBiggerOrEqualValue(start) & e.date.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> insertExpense(ExpensesCompanion expense) {
    return _db.into(_db.expenses).insert(expense);
  }

  Future<int> deleteExpense(String id) {
    return (_db.delete(_db.expenses)..where((e) => e.id.equals(id))).go();
  }
}
