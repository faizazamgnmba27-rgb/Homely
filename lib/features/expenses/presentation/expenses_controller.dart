import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../data/expenses_repository.dart';

final selectedExpenseMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

final monthlyExpensesProvider = StreamProvider<List<Expense>>((ref) {
  final repo = ref.watch(expensesRepositoryProvider);
  final selectedMonth = ref.watch(selectedExpenseMonthProvider);
  return repo.watchExpensesForMonth(selectedMonth.year, selectedMonth.month);
});

final monthlyTotalPaiseProvider = Provider<int>((ref) {
  final expensesAsync = ref.watch(monthlyExpensesProvider);
  return expensesAsync.maybeWhen(
    data: (expenses) => expenses.fold<int>(0, (sum, e) => sum + e.amountPaise),
    orElse: () => 0,
  );
});

final categoryBreakdownProvider = Provider<Map<String, int>>((ref) {
  final expensesAsync = ref.watch(monthlyExpensesProvider);
  return expensesAsync.maybeWhen(
    data: (expenses) {
      final Map<String, int> breakdown = {};
      for (final e in expenses) {
        breakdown[e.category] = (breakdown[e.category] ?? 0) + e.amountPaise;
      }
      return breakdown;
    },
    orElse: () => {},
  );
});
