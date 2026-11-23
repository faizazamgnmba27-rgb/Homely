import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../data/bills_repository.dart';
import 'bills_controller.dart';

class BillDetailsScreen extends ConsumerWidget {
  final String billId;

  const BillDetailsScreen({Key? key, required this.billId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final billAsync = ref.watch(billDetailProvider(billId));
    final paymentsAsync = ref.watch(billPaymentsProvider(billId));
    final repo = ref.watch(billsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bill Details',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: HomelyColors.danger),
            tooltip: 'Delete Bill',
            onPressed: () async {
              final confirmed = await HomelyConfirmDialog.show(
                context,
                title: 'Delete Bill',
                message: 'Are you sure you want to delete this bill and all its payment history?',
                isDestructive: true,
              );
              if (confirmed == true) {
                await repo.deleteBill(billId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: billAsync.when(
        data: (bill) {
          if (bill == null) {
            return const Center(child: Text('Bill not found'));
          }

          final isOverdue = bill.dueDate.isBefore(DateTime.now()) && bill.status != 'paid';

          return ListView(
            padding: const EdgeInsets.all(HomelySpacing.screenPadding),
            children: [
              // Hero Bill Card
              HomelyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bill.category.toUpperCase(),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent),
                        ),
                        if (isOverdue)
                          const HomelyBadge(
                            label: 'Overdue',
                            variant: HomelyBadgeVariant.danger,
                            icon: Icons.warning_amber_rounded,
                          )
                        else if (bill.status == 'paid')
                          const HomelyBadge(
                            label: 'Paid',
                            variant: HomelyBadgeVariant.success,
                            icon: Icons.check,
                          )
                        else
                          HomelyBadge(
                            label: 'Due ${DateFormatter.formatRelative(bill.dueDate)}',
                            variant: HomelyBadgeVariant.warning,
                          ),
                      ],
                    ),
                    const SizedBox(height: HomelySpacing.sm),
                    Text(
                      bill.name,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
                    ),
                    Text(
                      bill.provider,
                      style: TextStyle(fontSize: 13, color: secondary),
                    ),
                    const SizedBox(height: HomelySpacing.md),
                    Text(
                      CurrencyFormatter.formatPaise(bill.expectedAmountPaise, showDecimals: true),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: primary,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: HomelySpacing.md),
                    const Divider(),
                    const SizedBox(height: HomelySpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Billing Frequency', style: TextStyle(fontSize: 12, color: secondary)),
                        Text(bill.recurrence.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Due Date', style: TextStyle(fontSize: 12, color: secondary)),
                        Text(DateFormatter.formatDate(bill.dueDate), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: HomelySpacing.lg),

              // Payment History Section
              Text(
                'Payment History',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
              const SizedBox(height: HomelySpacing.sm),

              paymentsAsync.when(
                data: (payments) {
                  if (payments.isEmpty) {
                    return HomelyCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: HomelySpacing.md),
                          child: Text(
                            'No payment history yet.',
                            style: TextStyle(fontSize: 13, color: secondary),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: payments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final p = payments[index];
                      return HomelyCard(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: HomelyColors.success.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.check, size: 20, color: HomelyColors.success),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormatter.formatDate(p.paymentDate),
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primary),
                                    ),
                                    Text(
                                      'Method: ${p.paymentMethod}',
                                      style: TextStyle(fontSize: 11, color: secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              CurrencyFormatter.formatPaise(p.paidAmountPaise),
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error loading payments: $e'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
