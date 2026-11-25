import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/providers/budget_provider.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_card.dart';
import 'add_expense_sheet.dart';
import 'expenses_controller.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final selectedMonth = ref.watch(selectedExpenseMonthProvider);
    final totalPaise = ref.watch(monthlyTotalPaiseProvider);
    final categoryBreakdown = ref.watch(categoryBreakdownProvider);
    final expensesAsync = ref.watch(monthlyExpensesProvider);

    final monthlyBudgetPaise = ref.watch(monthlyBudgetProvider);
    final budgetPercent = (totalPaise / (monthlyBudgetPaise > 0 ? monthlyBudgetPaise : 1)).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Analytics',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: accent, size: 24),
            tooltip: 'Record Daily Expense',
            onPressed: () => AddExpenseSheet.show(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          HomelySpacing.screenPadding,
          HomelySpacing.xs,
          HomelySpacing.screenPadding,
          80,
        ),
        children: [
          // 1. Month Switcher
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  ref.read(selectedExpenseMonthProvider.notifier).state =
                      DateTime(selectedMonth.year, selectedMonth.month - 1);
                },
              ),
              Text(
                DateFormatter.formatMonthYear(selectedMonth),
                style: TextStyle(fontFamily: 'Manrope', fontSize: 16, fontWeight: FontWeight.w700, color: primary),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  ref.read(selectedExpenseMonthProvider.notifier).state =
                      DateTime(selectedMonth.year, selectedMonth.month + 1);
                },
              ),
            ],
          ),

          const SizedBox(height: HomelySpacing.xs),

          // 2. Spending Hero Card
          HomelyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly Expenditure', style: TextStyle(fontSize: 12, color: secondary)),
                const SizedBox(height: 4),
                Text(
                  CurrencyFormatter.formatPaise(totalPaise, showDecimals: true),
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: primary,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: HomelySpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Budget: ${CurrencyFormatter.formatPaise(monthlyBudgetPaise)}', style: TextStyle(fontSize: 11, color: secondary)),
                    Text('${(budgetPercent * 100).toStringAsFixed(0)}% Utilized', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent)),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: budgetPercent,
                  backgroundColor: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    budgetPercent > 0.9 ? HomelyColors.danger : accent,
                  ),
                  borderRadius: BorderRadius.circular(999),
                  minHeight: 6,
                ),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.md),

          // 3. Category Pie Chart (fl_chart)
          if (categoryBreakdown.isNotEmpty) ...[
            HomelyCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category Breakdown', style: TextStyle(fontFamily: 'Manrope', fontSize: 15, fontWeight: FontWeight.w700, color: primary)),
                  const SizedBox(height: HomelySpacing.md),
                  SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 3,
                        centerSpaceRadius: 40,
                        sections: categoryBreakdown.entries.map((entry) {
                          final color = _getCategoryColor(entry.key);
                          final percent = (entry.value / totalPaise) * 100;
                          return PieChartSectionData(
                            color: color,
                            value: entry.value.toDouble(),
                            title: '${percent.toStringAsFixed(0)}%',
                            radius: 36,
                            titleStyle: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: HomelySpacing.sm),
                  // Legend
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: categoryBreakdown.entries.map((entry) {
                      final color = _getCategoryColor(entry.key);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                          const SizedBox(width: 4),
                          Text('${entry.key.toUpperCase()}: ${CurrencyFormatter.formatPaise(entry.value)}', style: TextStyle(fontSize: 11, color: secondary)),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: HomelySpacing.md),
          ],

          // 4. Recent Expenses History
          Text('Expense Log', style: TextStyle(fontFamily: 'Manrope', fontSize: 16, fontWeight: FontWeight.w700, color: primary)),
          const SizedBox(height: HomelySpacing.xs),

          expensesAsync.when(
            data: (expenses) {
              if (expenses.isEmpty) {
                return HomelyCard(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: HomelySpacing.md),
                      child: Text('No expenses recorded for this month.', style: TextStyle(fontSize: 13, color: secondary)),
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final e = expenses[index];
                  return HomelyCard(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _getCategoryColor(e.category).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.arrow_outward, size: 18, color: _getCategoryColor(e.category)),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title,
                                  style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary),
                                ),
                                Text(
                                  '${DateFormatter.formatDate(e.date)} • ${e.paymentMethod}',
                                  style: TextStyle(fontSize: 11, color: secondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          CurrencyFormatter.formatPaise(e.amountPaise),
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
            error: (e, _) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'utility':
        return Colors.blue;
      case 'grocery':
      case 'groceries':
        return Colors.green;
      case 'shopping':
        return Colors.teal;
      case 'vehicle':
        return Colors.brown;
      case 'maintenance':
        return Colors.orange;
      default:
        return HomelyColors.lightAccent;
    }
  }
}
