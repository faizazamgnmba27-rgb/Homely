import 'package:intl/intl.dart';
import '../models/app_currency.dart';

/// All monetary calculations in HOMELY use 64-bit integer minor units (paise/cents/pence).
/// Floating point currencies are strictly prohibited to avoid binary IEEE 754 precision errors.
class CurrencyFormatter {
  /// The global active currency. Defaults to Indian Rupee (INR).
  static AppCurrency activeCurrency = AppCurrency.inr;

  /// Cached formatters for performance
  static final Map<String, NumberFormat> _formattersNoDecimals = {};
  static final Map<String, NumberFormat> _formattersWithDecimals = {};

  static NumberFormat _getFormatter(AppCurrency currency, bool withDecimals) {
    final key = '${currency.code}_$withDecimals';
    if (withDecimals) {
      return _formattersWithDecimals.putIfAbsent(
        key,
        () => NumberFormat.currency(
          locale: currency.locale,
          symbol: currency.symbol,
          decimalDigits: currency.decimalDigits,
        ),
      );
    } else {
      return _formattersNoDecimals.putIfAbsent(
        key,
        () => NumberFormat.currency(
          locale: currency.locale,
          symbol: currency.symbol,
          decimalDigits: 0,
        ),
      );
    }
  }

  /// Format minor units (paise/cents/pence) to formatted currency string, e.g. 145000 -> "₹1,450" or "$1,450"
  static String formatPaise(
    int minorUnits, {
    bool showDecimals = false,
    AppCurrency? currency,
  }) {
    final curr = currency ?? activeCurrency;
    final divisor = curr.decimalDigits == 0 ? 1.0 : 100.0;
    final majorUnits = minorUnits / divisor;

    final hasFraction = (minorUnits % (divisor.toInt())) != 0;
    final needDecimals = showDecimals || (hasFraction && curr.decimalDigits > 0);

    return _getFormatter(curr, needDecimals).format(majorUnits);
  }

  /// Alias for formatPaise with currency agnostic naming
  static String formatMinorUnits(
    int minorUnits, {
    bool showDecimals = false,
    AppCurrency? currency,
  }) {
    return formatPaise(minorUnits, showDecimals: showDecimals, currency: currency);
  }

  /// Parse user input string e.g. "1,450.50" or "$1,450" to integer minor units
  static int parseToPaise(String input, {AppCurrency? currency}) {
    if (input.trim().isEmpty) return 0;
    final curr = currency ?? activeCurrency;

    // Strip currency symbols, commas, and spaces
    String clean = input
        .replaceAll(curr.symbol, '')
        .replaceAll('₹', '')
        .replaceAll('\$', '')
        .replaceAll('€', '')
        .replaceAll('£', '')
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .trim();

    final value = double.tryParse(clean);
    if (value == null) return 0;

    final multiplier = curr.decimalDigits == 0 ? 1 : 100;
    return (value * multiplier).round();
  }

  /// Convert standard double major units (rupees/dollars) to integer minor units (paise/cents)
  static int rupeesToPaise(double majorUnits, {AppCurrency? currency}) {
    final curr = currency ?? activeCurrency;
    final multiplier = curr.decimalDigits == 0 ? 1 : 100;
    return (majorUnits * multiplier).round();
  }

  /// Convert integer minor units to double major units (for chart data plotting only)
  static double paiseToRupees(int minorUnits, {AppCurrency? currency}) {
    final curr = currency ?? activeCurrency;
    final divisor = curr.decimalDigits == 0 ? 1.0 : 100.0;
    return minorUnits / divisor;
  }
}
