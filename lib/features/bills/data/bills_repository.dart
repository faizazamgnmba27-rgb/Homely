import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final billsRepositoryProvider = Provider<BillsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BillsRepository(db);
});

class BillsRepository {
  final AppDatabase _db;

  BillsRepository(this._db);

  Stream<List<Bill>> watchActiveBills() {
    return (_db.select(_db.bills)
          ..where((b) => b.isArchived.equals(false))
          ..orderBy([(b) => OrderingTerm(expression: b.dueDate)]))
        .watch();
  }

  Stream<List<Bill>> watchUpcomingBills() {
    final now = DateTime.now();
    return (_db.select(_db.bills)
          ..where((b) => b.isArchived.equals(false) & b.dueDate.isBiggerOrEqualValue(now) & b.status.equals('upcoming'))
          ..orderBy([(b) => OrderingTerm(expression: b.dueDate)]))
        .watch();
  }

  Stream<List<Bill>> watchOverdueBills() {
    final now = DateTime.now();
    return (_db.select(_db.bills)
          ..where((b) => b.isArchived.equals(false) & b.dueDate.isSmallerThanValue(now) & b.status.equals('upcoming'))
          ..orderBy([(b) => OrderingTerm(expression: b.dueDate)]))
        .watch();
  }

  Stream<Bill?> watchBillById(String id) {
    return (_db.select(_db.bills)..where((b) => b.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<BillPayment>> watchPaymentsForBill(String billId) {
    return (_db.select(_db.billPayments)
          ..where((p) => p.billId.equals(billId))
          ..orderBy([(p) => OrderingTerm(expression: p.paymentDate, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> insertBill(BillsCompanion bill) {
    return _db.into(_db.bills).insert(bill);
  }

  Future<bool> updateBill(BillsCompanion bill) {
    return _db.update(_db.bills).replace(bill);
  }

  Future<int> deleteBill(String id) {
    return (_db.delete(_db.bills)..where((b) => b.id.equals(id))).go();
  }

  /// Marks bill as paid: logs payment, adds to expenses, and advances next recurring cycle if applicable
  Future<void> markBillAsPaid({
    required String billId,
    required int actualAmountPaise,
    required DateTime paymentDate,
    String paymentMethod = 'UPI',
    String? receiptPath,
    String? notes,
  }) async {
    await _db.transaction(() async {
      final bill = await (_db.select(_db.bills)..where((b) => b.id.equals(billId))).getSingleOrNull();
      if (bill == null) return;

      final paymentId = const Uuid().v4();

      // 1. Log payment
      await _db.into(_db.billPayments).insert(
            BillPaymentsCompanion.insert(
              id: paymentId,
              billId: billId,
              paidAmountPaise: actualAmountPaise,
              paymentDate: paymentDate,
              paymentMethod: Value(paymentMethod),
              receiptAttachmentPath: Value(receiptPath),
              notes: Value(notes),
              createdAt: DateTime.now(),
            ),
          );

      // 2. Log in Expenses
      await _db.into(_db.expenses).insert(
            ExpensesCompanion.insert(
              id: const Uuid().v4(),
              title: '${bill.name} (${bill.provider})',
              category: 'utility',
              amountPaise: actualAmountPaise,
              date: paymentDate,
              paymentMethod: Value(paymentMethod),
              linkedEntityId: Value(paymentId),
              linkedEntityType: const Value('bill_payment'),
              createdAt: DateTime.now(),
            ),
          );

      // 3. Handle Recurrence
      if (bill.recurrence != 'one_time') {
        final nextDueDate = calculateNextDueDate(bill.dueDate, bill.recurrence);
        await (_db.update(_db.bills)..where((b) => b.id.equals(billId))).write(
          BillsCompanion(
            dueDate: Value(nextDueDate),
            status: const Value('upcoming'),
            updatedAt: Value(DateTime.now()),
          ),
        );
      } else {
        await (_db.update(_db.bills)..where((b) => b.id.equals(billId))).write(
          BillsCompanion(
            status: const Value('paid'),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  /// Calculates next due date correctly handling months with fewer days (e.g. 31st)
  static DateTime calculateNextDueDate(DateTime currentDue, String recurrence) {
    switch (recurrence) {
      case 'weekly':
        return currentDue.add(const Duration(days: 7));
      case 'monthly':
        return addMonthsWithDayClamp(currentDue, 1);
      case 'quarterly':
        return addMonthsWithDayClamp(currentDue, 3);
      case 'yearly':
        return addMonthsWithDayClamp(currentDue, 12);
      default:
        return currentDue;
    }
  }

  /// Handles months with fewer days like Feb 28/29 or 30-day months when due on the 31st
  static DateTime addMonthsWithDayClamp(DateTime date, int monthsToAdd) {
    var year = date.year;
    var month = date.month + monthsToAdd;

    while (month > 12) {
      year += 1;
      month -= 12;
    }

    final maxDaysInNewMonth = DateTime(year, month + 1, 0).day;
    final clampedDay = date.day > maxDaysInNewMonth ? maxDaysInNewMonth : date.day;

    return DateTime(year, month, clampedDay, date.hour, date.minute, date.second);
  }
}
