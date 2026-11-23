import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_currency.dart';
import '../utils/currency_formatter.dart';

const String _currencyPrefKey = 'homely_selected_currency';

class CurrencyNotifier extends StateNotifier<AppCurrency> {
  CurrencyNotifier() : super(AppCurrency.inr) {
    _loadFromPreferences();
  }

  Future<void> _loadFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_currencyPrefKey);
      if (code != null) {
        final currency = AppCurrency.fromCode(code);
        state = currency;
        CurrencyFormatter.activeCurrency = currency;
      }
    } catch (_) {
      // Keep default INR if prefs fail
    }
  }

  Future<void> setCurrency(AppCurrency currency) async {
    state = currency;
    CurrencyFormatter.activeCurrency = currency;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currencyPrefKey, currency.code);
    } catch (_) {}
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, AppCurrency>((ref) {
  return CurrencyNotifier();
});
