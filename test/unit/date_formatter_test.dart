import 'package:flutter_test/flutter_test.dart';
import 'package:homely/core/utils/date_formatter.dart';

void main() {
  group('DateFormatter Relative & Warranty Tests', () {
    test('Formats relative dates for today, tomorrow, yesterday', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final yesterday = today.subtract(const Duration(days: 1));

      expect(DateFormatter.formatRelative(today), 'Today');
      expect(DateFormatter.formatRelative(tomorrow), 'Tomorrow');
      expect(DateFormatter.formatRelative(yesterday), 'Yesterday');
    });

    test('Calculates remaining warranty formatting', () {
      final now = DateTime.now();
      final pastDate = now.subtract(const Duration(days: 10));
      expect(DateFormatter.formatRemainingWarranty(pastDate), 'Warranty Expired');

      final twoYearsAhead = now.add(const Duration(days: 365 * 2 + 65));
      expect(DateFormatter.formatRemainingWarranty(twoYearsAhead).contains('yr'), true);
    });
  });
}
