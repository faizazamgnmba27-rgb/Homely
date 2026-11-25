import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_section_header.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: HomelySpacing.screenPadding,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.home_outlined, color: isDark ? const Color(0xFF151714) : Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              'HOMELY',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune_outlined, color: secondary, size: 22),
            onPressed: () => context.push('/settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardMetricsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            HomelySpacing.screenPadding,
            HomelySpacing.xs,
            HomelySpacing.screenPadding,
            80,
          ),
          children: [
            // Greeting & Date Header
            Text(
              _getGreeting(),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: primary,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              DateFormatter.formatDate(DateTime.now()),
              style: TextStyle(fontSize: 13, color: secondary),
            ),

            const SizedBox(height: HomelySpacing.md),

            // Metrics Async
            metricsAsync.when(
              data: (m) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section A: Monthly Overview Hero Card
                    HomelyCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Monthly Household Spending', style: TextStyle(fontSize: 12, color: secondary)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  '${m.upcomingBillsCount} Bills Due',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            CurrencyFormatter.formatPaise(m.currentMonthSpendingPaise, showDecimals: true),
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: primary,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: HomelySpacing.sm),
                          const Divider(),
                          const SizedBox(height: HomelySpacing.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Upcoming Bills Total', style: TextStyle(fontSize: 12, color: secondary)),
                              Text(
                                CurrencyFormatter.formatPaise(m.upcomingBillsTotalPaise),
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: HomelySpacing.lg),

                    // Section B: Quick Action Bar
                    SizedBox(
                      height: 38,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildQuickActionChip(context, '+ Grocery', () => context.push('/inventory/add'), accent, isDark),
                          const SizedBox(width: 8),
                          _buildQuickActionChip(context, '+ Bill', () => context.push('/bills/add'), accent, isDark),
                          const SizedBox(width: 8),
                          _buildQuickActionChip(context, '+ Wishlist', () => context.push('/shopping/add'), accent, isDark),
                          const SizedBox(width: 8),
                          _buildQuickActionChip(context, '+ Asset', () => context.push('/assets/add'), accent, isDark),
                          const SizedBox(width: 8),
                          _buildQuickActionChip(context, '+ Reminder', () => context.push('/reminders/add'), accent, isDark),
                        ],
                      ),
                    ),

                    const SizedBox(height: HomelySpacing.lg),

                    // Section C: Household Priorities & Upcoming Bills
                    HomelySectionHeader(
                      title: 'Upcoming Bills',
                      count: m.upcomingBillsCount,
                      actionText: 'See all',
                      onAction: () => context.push('/bills'),
                    ),
                    if (m.upcomingBills.isEmpty)
                      HomelyCard(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text('No bills due this cycle.', style: TextStyle(fontSize: 13, color: secondary)),
                          ),
                        ),
                      )
                    else
                      ...m.upcomingBills.map((b) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: HomelyCard(
                              onTap: () => context.push('/bills/${b.id}'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.receipt_long, size: 20, color: secondary),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(b.name, style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                                          Text('Due ${DateFormatter.formatRelative(b.dueDate)}', style: TextStyle(fontSize: 11, color: secondary)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    CurrencyFormatter.formatPaise(b.expectedAmountPaise),
                                    style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: primary),
                                  ),
                                ],
                              ),
                            ),
                          )),

                    const SizedBox(height: HomelySpacing.md),

                    // Section: Shopping & Wishlist Alerts
                    HomelySectionHeader(
                      title: 'Shopping & Wishlist',
                      count: m.upcomingPurchasesCount,
                      actionText: 'View list',
                      onAction: () => context.push('/shopping'),
                    ),
                    if (m.upcomingPurchases.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: HomelyCard(
                          onTap: () => context.push('/shopping/add'),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6B8FB2).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.favorite_border_rounded, size: 20, color: Color(0xFF6B8FB2)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('No Pending Wishlist Items', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                                    Text('Tap to plan your next household purchase', style: TextStyle(fontSize: 11, color: secondary)),
                                  ],
                                ),
                              ),
                              Icon(Icons.add_circle_outline_rounded, size: 20, color: accent),
                            ],
                          ),
                        ),
                      )
                    else
                      ...m.upcomingPurchases.map((item) {
                        final isHigh = item.priority.toLowerCase() == 'high';
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: HomelyCard(
                            onTap: () => context.push('/shopping'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: isHigh
                                            ? HomelyColors.warning.withOpacity(0.12)
                                            : const Color(0xFF6B8FB2).withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        isHigh ? Icons.priority_high_rounded : Icons.favorite_rounded,
                                        size: 20,
                                        color: isHigh ? HomelyColors.warning : const Color(0xFF6B8FB2),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primary,
                                          ),
                                        ),
                                        Text(
                                          'Planned: ${DateFormatter.formatDate(item.plannedPurchaseDate)} • ${item.quantity.toInt()} ${item.unit}',
                                          style: TextStyle(fontSize: 11, color: secondary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (item.expectedPricePaise != null && item.expectedPricePaise! > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Text(
                                          CurrencyFormatter.formatPaise(item.expectedPricePaise!),
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: primary,
                                          ),
                                        ),
                                      ),
                                    HomelyBadge(
                                      label: item.priority.toUpperCase(),
                                      variant: isHigh ? HomelyBadgeVariant.warning : HomelyBadgeVariant.neutral,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                    const SizedBox(height: HomelySpacing.md),

                    // Section D: Low Stock Inventory Alerts
                    if (m.lowStockItems.isNotEmpty) ...[
                      HomelySectionHeader(
                        title: 'Low Stock Essentials',
                        count: m.lowStockCount,
                        actionText: 'Inventory',
                        onAction: () => context.go('/inventory'),
                      ),
                      ...m.lowStockItems.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: HomelyCard(
                              onTap: () => context.go('/inventory'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: HomelyColors.warning.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(Icons.warning_amber_rounded, size: 20, color: HomelyColors.warning),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.name, style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                                          Text('Left: ${item.quantity} ${item.unit} (Min: ${item.minStockThreshold})', style: TextStyle(fontSize: 11, color: secondary)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const HomelyBadge(
                                    label: 'Restock',
                                    variant: HomelyBadgeVariant.warning,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(height: HomelySpacing.md),
                    ],

                    // Section E: Expiring Warranties
                    if (m.expiringAssets.isNotEmpty) ...[
                      HomelySectionHeader(
                        title: 'Expiring Warranties',
                        count: m.expiringWarrantiesCount,
                        actionText: 'Assets',
                        onAction: () => context.push('/assets'),
                      ),
                      ...m.expiringAssets.map((asset) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: HomelyCard(
                              onTap: () => context.push('/assets/${asset.id}'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.kitchen_outlined, size: 20, color: secondary),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(asset.name, style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                                          Text('Expires ${DateFormatter.formatDate(asset.warrantyExpiryDate)}', style: TextStyle(fontSize: 11, color: secondary)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  HomelyBadge(
                                    label: DateFormatter.formatRemainingWarranty(asset.warrantyExpiryDate),
                                    variant: HomelyBadgeVariant.warning,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Center(child: Text('Error loading dashboard: $e')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionChip(BuildContext context, String label, VoidCallback onTap, Color accent, bool isDark) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      side: BorderSide(
        color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
      ),
    );
  }
}
