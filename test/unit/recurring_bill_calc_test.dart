import 'package:flutter_test/flutter_test.dart';
import 'package:homely/features/bills/data/bills_repository.dart';

void main() {
  group('Recurring Bill Due Date Calculation Tests', () {
    test('Clamps month days correctly when billing on the 31st', () {
      // 31st Jan -> next month should be 28th Feb (or 29th in leap year)
      final jan31 = DateTime(2026, 1, 31);
      final nextFeb = BillsRepository.calculateNextDueDate(jan31, 'monthly');
      expect(nextFeb.month, 2);
      expect(nextFeb.day, 28);

      // March 31st -> April 30th
      final march31 = DateTime(2026, 3, 31);
      final nextApril = BillsRepository.calculateNextDueDate(march31, 'monthly');
      expect(nextApril.month, 4);
      expect(nextApril.day, 30);
    });

    test('Calculates quarterly due date correctly', () {
      final jan15 = DateTime(2026, 1, 15);
      final nextQuarter = BillsRepository.calculateNextDueDate(jan15, 'quarterly');
      expect(nextQuarter.month, 4);
      expect(nextQuarter.day, 15);
    });

    test('Calculates yearly due date correctly', () {
      final nov21 = DateTime(2026, 11, 21);
      final nextYear = BillsRepository.calculateNextDueDate(nov21, 'yearly');
      expect(nextYear.year, 2027);
      expect(nextYear.month, 11);
      expect(nextYear.day, 21);
    });
  });
}
