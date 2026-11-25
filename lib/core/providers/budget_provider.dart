import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/theme/homely_theme_provider.dart';

const String _budgetPrefKey = 'homely_monthly_budget_paise';
const int defaultMonthlyBudgetPaise = 5000000; // ₹50,000

class BudgetNotifier extends StateNotifier<int> {
  final SharedPreferences _prefs;

  BudgetNotifier(this._prefs) : super(_loadBudget(_prefs));

  static int _loadBudget(SharedPreferences prefs) {
    return prefs.getInt(_budgetPrefKey) ?? defaultMonthlyBudgetPaise;
  }

  Future<void> setBudget(int budgetPaise) async {
    state = budgetPaise;
    await _prefs.setInt(_budgetPrefKey, budgetPaise);
  }
}

final monthlyBudgetProvider = StateNotifierProvider<BudgetNotifier, int>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return BudgetNotifier(prefs);
});
