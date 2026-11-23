import 'package:flutter_test/flutter_test.dart';
import 'package:homely/core/models/app_currency.dart';
import 'package:homely/core/utils/currency_formatter.dart';

void main() {
  setUp(() {
    CurrencyFormatter.activeCurrency = AppCurrency.inr;
  });

  group('CurrencyFormatter Tests (Integer Minor Units Architecture)', () {
    test('Formats integer paise into Indian Rupee symbol correctly', () {
      expect(CurrencyFormatter.formatPaise(10000), '₹100');
      expect(CurrencyFormatter.formatPaise(125000), '₹1,250');
      expect(CurrencyFormatter.formatPaise(5000000), '₹50,000');
      expect(CurrencyFormatter.formatPaise(145050, showDecimals: true), '₹1,450.50');
    });

    test('Formats amounts into alternative currencies (USD, EUR, GBP, AED, JPY)', () {
      expect(CurrencyFormatter.formatPaise(10000, currency: AppCurrency.usd), '\$100');
      expect(CurrencyFormatter.formatPaise(145050, currency: AppCurrency.usd, showDecimals: true), '\$1,450.50');
      expect(CurrencyFormatter.formatPaise(250000, currency: AppCurrency.eur), '2.500 €');
      expect(CurrencyFormatter.formatPaise(120000, currency: AppCurrency.gbp), '£1,200');
      expect(CurrencyFormatter.formatPaise(50000, currency: AppCurrency.aed), 'د.إ 500');
      // JPY has 0 decimal digits
      expect(CurrencyFormatter.formatPaise(5000, currency: AppCurrency.jpy), '¥5,000');
    });

    test('Parses currency user input string into exact integer minor units', () {
      expect(CurrencyFormatter.parseToPaise('100'), 10000);
      expect(CurrencyFormatter.parseToPaise('1,450'), 145000);
      expect(CurrencyFormatter.parseToPaise('₹ 1,450.50'), 145050);
      expect(CurrencyFormatter.parseToPaise('\$ 2,500.00', currency: AppCurrency.usd), 250000);
      expect(CurrencyFormatter.parseToPaise('€ 45.90', currency: AppCurrency.eur), 4590);
      expect(CurrencyFormatter.parseToPaise('   ₹250   '), 25000);
      expect(CurrencyFormatter.parseToPaise(''), 0);
    });

    test('Converts double major units to integer minor units without floating point inaccuracy', () {
      expect(CurrencyFormatter.rupeesToPaise(199.99), 19999);
      expect(CurrencyFormatter.paiseToRupees(19999), 199.99);
    });
  });
}
