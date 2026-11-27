import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/services/sms_bill_parser.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_empty_state.dart';
import '../data/bills_repository.dart';
import 'bills_controller.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({Key? key}) : super(key: key);

  Future<void> _importBillsFromSms(BuildContext context, WidgetRef ref) async {
    try {
      final parsed = await SmsBillParser.fetchAndParseBills();
      if (!context.mounted) return;
      if (parsed.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No credit card or utility bill SMS found.')),
        );
        return;
      }

      final selected = List<bool>.filled(parsed.length, true);
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
          final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
          final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
                decoration: BoxDecoration(
                  color: isDark ? HomelyColors.darkCard : HomelyColors.lightCard,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(HomelySpacing.sheetRadius)),
                ),
                padding: const EdgeInsets.fromLTRB(
                  HomelySpacing.screenPadding,
                  HomelySpacing.md,
                  HomelySpacing.screenPadding,
                  HomelySpacing.lg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detected Bills from SMS (${parsed.length})',
                      style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select the bills you want to add to your Bills section.',
                      style: TextStyle(fontSize: 12, color: secondary),
                    ),
                    const SizedBox(height: HomelySpacing.sm),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: parsed.length,
                        itemBuilder: (c, i) {
                          final b = parsed[i];
                          return CheckboxListTile(
                            value: selected[i],
                            activeColor: accent,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (v) => setState(() => selected[i] = v ?? false),
                            title: Text(b.name, style: TextStyle(fontWeight: FontWeight.w600, color: primary)),
                            subtitle: Text(
                              'Due ${DateFormatter.formatShortDate(b.dueDate)} • ${b.category}',
                              style: TextStyle(fontSize: 12, color: secondary),
                            ),
                            secondary: Text(
                              CurrencyFormatter.formatPaise(b.amountPaise),
                              style: TextStyle(fontWeight: FontWeight.w700, color: primary),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: HomelySpacing.md),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          final repo = ref.read(billsRepositoryProvider);
                          final now = DateTime.now();
                          int added = 0;
                          for (int i = 0; i < parsed.length; i++) {
                            if (!selected[i]) continue;
                            final b = parsed[i];
                            await repo.insertBill(
                              BillsCompanion.insert(
                                id: const Uuid().v4(),
                                name: b.name,
                                provider: b.provider,
                                category: b.category,
                                expectedAmountPaise: b.amountPaise,
                                dueDate: b.dueDate,
                                notes: drift.Value('Imported from SMS: ${b.rawBody}'),
                                createdAt: now,
                                updatedAt: now,
                              ),
                            );
                            added++;
                          }
                          if (ctx.mounted) Navigator.pop(ctx);
                          if (context.mounted && added > 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added $added bill(s) from SMS!')),
                            );
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Add Selected to Bills', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not read SMS: $e')),
        );
      }
    }
  }

  void _showMarkPaidModal(BuildContext context, WidgetRef ref, Bill bill) {
    final amountController = TextEditingController(
      text: (bill.expectedAmountPaise / 100).toStringAsFixed(0),
    );
    DateTime paymentDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDark ? HomelyColors.darkCard : HomelyColors.lightCard,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(HomelySpacing.sheetRadius)),
              ),
              padding: EdgeInsets.fromLTRB(
                HomelySpacing.screenPadding,
                HomelySpacing.md,
                HomelySpacing.screenPadding,
                MediaQuery.of(context).viewInsets.bottom + HomelySpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mark Bill as Paid',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${bill.name} (${bill.provider})',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: HomelySpacing.md),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Actual Amount Paid (₹)',
                      prefixText: '₹ ',
                    ),
                  ),
                  const SizedBox(height: HomelySpacing.sm),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: paymentDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => paymentDate = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Payment Date'),
                      child: Text(DateFormatter.formatDate(paymentDate)),
                    ),
                  ),
                  const SizedBox(height: HomelySpacing.lg),
                  FilledButton(
                    onPressed: () async {
                      final paise = CurrencyFormatter.parseToPaise(amountController.text);
                      final repo = ref.read(billsRepositoryProvider);
                      await repo.markBillAsPaid(
                        billId: bill.id,
                        actualAmountPaise: paise,
                        paymentDate: paymentDate,
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${bill.name} marked as paid!')),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent,
                      foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Confirm Payment', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final billsAsync = ref.watch(activeBillsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bills & Subscriptions',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sms_outlined, color: accent, size: 22),
            tooltip: 'Fetch Bills from SMS',
            onPressed: () => _importBillsFromSms(context, ref),
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: accent, size: 24),
            tooltip: 'Add Bill',
            onPressed: () => context.push('/bills/add'),
          ),
        ],
      ),
      body: billsAsync.when(
        data: (bills) {
          if (bills.isEmpty) {
            return HomelyEmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No Bills Scheduled',
              message: 'Track electricity, Wi-Fi, water, LPG, rent, and subscriptions with due date alerts.',
              actionLabel: 'Add First Bill',
              onAction: () => context.push('/bills/add'),
            );
          }

          // Calculate total upcoming sum
          final totalUpcomingPaise = bills
              .where((b) => b.status == 'upcoming')
              .fold<int>(0, (sum, b) => sum + b.expectedAmountPaise);

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              HomelySpacing.screenPadding,
              HomelySpacing.xs,
              HomelySpacing.screenPadding,
              80,
            ),
            children: [
              // Summary Banner Card
              HomelyCard(
                backgroundColor: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Upcoming', style: TextStyle(fontSize: 12, color: secondary)),
                        const SizedBox(height: 2),
                        Text(
                          CurrencyFormatter.formatPaise(totalUpcomingPaise),
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? HomelyColors.darkCard : HomelyColors.lightCard,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                        ),
                      ),
                      child: Text(
                        '${bills.where((b) => b.status == 'upcoming').length} Due Soon',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: HomelySpacing.md),

              // Bills List
              ...bills.map((bill) {
                final isOverdue = bill.dueDate.isBefore(DateTime.now()) && bill.status != 'paid';

                return Padding(
                  padding: const EdgeInsets.only(bottom: HomelySpacing.sm),
                  child: HomelyCard(
                    onTap: () => context.push('/bills/${bill.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                                ),
                              ),
                              child: Icon(
                                _getCategoryIcon(bill.category),
                                color: secondary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: HomelySpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          bill.name,
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: primary,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        CurrencyFormatter.formatPaise(bill.expectedAmountPaise),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${bill.provider} • Due ${DateFormatter.formatRelative(bill.dueDate)}',
                                    style: TextStyle(fontSize: 12, color: secondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: HomelySpacing.sm),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 6,
                              children: [
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
                                    label: bill.recurrence.toUpperCase(),
                                    variant: HomelyBadgeVariant.neutral,
                                  ),
                              ],
                            ),
                            if (bill.status != 'paid')
                              FilledButton(
                                onPressed: () => _showMarkPaidModal(context, ref, bill),
                                style: FilledButton.styleFrom(
                                  backgroundColor: accent,
                                  foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  visualDensity: VisualDensity.compact,
                                ),
                                child: const Text('Mark Paid', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  IconData _getCategoryIcon(String cat) {
    switch (cat.toLowerCase()) {
      case 'electricity':
        return Icons.bolt;
      case 'wifi':
        return Icons.wifi;
      case 'water':
        return Icons.water_drop_outlined;
      case 'lpg':
        return Icons.local_gas_station_outlined;
      case 'rent':
        return Icons.home_work_outlined;
      case 'ott':
        return Icons.movie_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }
}
