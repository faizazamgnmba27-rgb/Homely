import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../data/bills_repository.dart';

final activeBillsProvider = StreamProvider<List<Bill>>((ref) {
  final repo = ref.watch(billsRepositoryProvider);
  return repo.watchActiveBills();
});

final upcomingBillsProvider = StreamProvider<List<Bill>>((ref) {
  final repo = ref.watch(billsRepositoryProvider);
  return repo.watchUpcomingBills();
});

final overdueBillsProvider = StreamProvider<List<Bill>>((ref) {
  final repo = ref.watch(billsRepositoryProvider);
  return repo.watchOverdueBills();
});

final billDetailProvider = StreamProvider.family<Bill?, String>((ref, billId) {
  final repo = ref.watch(billsRepositoryProvider);
  return repo.watchBillById(billId);
});

final billPaymentsProvider = StreamProvider.family<List<BillPayment>, String>((ref, billId) {
  final repo = ref.watch(billsRepositoryProvider);
  return repo.watchPaymentsForBill(billId);
});
