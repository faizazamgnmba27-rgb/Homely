import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_empty_state.dart';
import 'assets_controller.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final assetsAsync = ref.watch(allAssetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assets & Appliances',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: accent, size: 24),
            tooltip: 'Add Appliance',
            onPressed: () => context.push('/assets/add'),
          ),
        ],
      ),
      body: assetsAsync.when(
        data: (assets) {
          if (assets.isEmpty) {
            return HomelyEmptyState(
              icon: Icons.kitchen_outlined,
              title: 'No Assets Registered',
              message: 'Track electronics, refrigerators, ACs, warranty expiration dates, and service schedules.',
              actionLabel: 'Add First Asset',
              onAction: () => context.push('/assets/add'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              HomelySpacing.screenPadding,
              HomelySpacing.sm,
              HomelySpacing.screenPadding,
              80,
            ),
            itemCount: assets.length,
            separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
            itemBuilder: (context, index) {
              final a = assets[index];
              final isExpired = a.warrantyExpiryDate.isBefore(DateTime.now());
              final isExpiringSoon = !isExpired && a.warrantyExpiryDate.difference(DateTime.now()).inDays <= 30;

              return HomelyCard(
                onTap: () => context.push('/assets/${a.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Icon(_getAssetIcon(a.category), color: secondary, size: 22),
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
                                      a.name,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                  if (a.purchasePricePaise != null)
                                    Text(
                                      CurrencyFormatter.formatPaise(a.purchasePricePaise!),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${a.brand ?? ''} ${a.model ?? ''}'.trim(),
                                style: TextStyle(fontSize: 12, color: secondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: HomelySpacing.sm),

                    // Warranty Countdown & Service Info Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 6,
                          children: [
                            if (isExpired)
                              const HomelyBadge(
                                label: 'Warranty Expired',
                                variant: HomelyBadgeVariant.danger,
                                icon: Icons.warning_amber_rounded,
                              )
                            else if (isExpiringSoon)
                              HomelyBadge(
                                label: 'Expiring: ${DateFormatter.formatRemainingWarranty(a.warrantyExpiryDate)}',
                                variant: HomelyBadgeVariant.warning,
                                icon: Icons.schedule,
                              )
                            else
                              HomelyBadge(
                                label: 'Warranty: ${DateFormatter.formatRemainingWarranty(a.warrantyExpiryDate)}',
                                variant: HomelyBadgeVariant.neutral,
                              ),
                          ],
                        ),
                        if (a.nextServiceDate != null)
                          Text(
                            'Service: ${DateFormatter.formatShortDate(a.nextServiceDate!)}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: secondary),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  IconData _getAssetIcon(String cat) {
    switch (cat.toLowerCase()) {
      case 'refrigerator':
        return Icons.kitchen;
      case 'washing_machine':
        return Icons.local_laundry_service;
      case 'ac':
        return Icons.ac_unit;
      case 'tv':
        return Icons.tv;
      case 'laptop':
        return Icons.laptop_mac;
      case 'smartphone':
        return Icons.phone_android;
      case 'microwave':
        return Icons.microwave;
      default:
        return Icons.devices_other;
    }
  }
}
