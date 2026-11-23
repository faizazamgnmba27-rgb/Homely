import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/widgets/homely_card.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final menuItems = [
      {
        'title': 'Shopping Wishlist',
        'subtitle': 'Purchases & bucket planning',
        'icon': Icons.favorite_border_rounded,
        'route': '/shopping',
        'color': const Color(0xFF6B8FB2),
      },
      {
        'title': 'Bills & Subscriptions',
        'subtitle': 'Utilities, dues & payment history',
        'icon': Icons.receipt_long_outlined,
        'route': '/bills',
        'color': HomelyColors.warning,
      },
      {
        'title': 'Assets & Appliances',
        'subtitle': 'Warranties, models & service logs',
        'icon': Icons.kitchen_outlined,
        'route': '/assets',
        'color': const Color(0xFF9B82B5),
      },
      {
        'title': 'Vehicles & Garage',
        'subtitle': 'Odometers, fuel logs & PUC',
        'icon': Icons.directions_car_outlined,
        'route': '/vehicles',
        'color': const Color(0xFFA8896C),
      },
      {
        'title': 'Document Vault',
        'subtitle': 'Encrypted local invoices & files',
        'icon': Icons.lock_outline,
        'route': '/documents',
        'color': const Color(0xFF5BA390),
      },
      {
        'title': 'Expense Analytics',
        'subtitle': 'Monthly charts & budget meter',
        'icon': Icons.pie_chart_outline,
        'route': '/expenses',
        'color': const Color(0xFF6B9E78),
      },
      {
        'title': 'Settings & Privacy',
        'subtitle': 'Themes, local backup & restore',
        'icon': Icons.settings_outlined,
        'route': '/settings',
        'color': accent,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More Modules',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          HomelySpacing.screenPadding,
          HomelySpacing.xs,
          HomelySpacing.screenPadding,
          80,
        ),
        itemCount: menuItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final color = item['color'] as Color;

          return HomelyCard(
            onTap: () => context.push(item['route'] as String),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item['icon'] as IconData, color: color, size: 22),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['subtitle'] as String,
                        style: TextStyle(fontSize: 12, color: secondary),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, size: 20, color: secondary),
              ],
            ),
          );
        },
      ),
    );
  }
}
