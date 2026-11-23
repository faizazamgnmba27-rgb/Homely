import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/homely_colors.dart';
import '../constants/spacing.dart';

class HomelyQuickAddSheet extends StatelessWidget {
  const HomelyQuickAddSheet({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const HomelyQuickAddSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? HomelyColors.darkCard : HomelyColors.lightCard;
    final border = isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(HomelySpacing.sheetRadius)),
        border: Border(top: BorderSide(color: border, width: 1.0)),
      ),
      padding: EdgeInsets.fromLTRB(
        HomelySpacing.screenPadding,
        HomelySpacing.sm,
        HomelySpacing.screenPadding,
        MediaQuery.of(context).padding.bottom + HomelySpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: HomelySpacing.md),
          Text(
            'Quick Add',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Record a new entry to your household store',
            style: TextStyle(
              fontSize: 12,
              color: secondary,
            ),
          ),
          const SizedBox(height: HomelySpacing.md),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.3,
            children: [
              _buildActionTile(
                context,
                title: 'Add Grocery',
                subtitle: 'Kitchen stock item',
                icon: Icons.inventory_2_outlined,
                accentColor: isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent,
                onTap: () {
                  Navigator.pop(context);
                  context.push('/inventory/add');
                },
              ),
              _buildActionTile(
                context,
                title: 'Add Bill',
                subtitle: 'Utility or subscription',
                icon: Icons.receipt_long_outlined,
                accentColor: HomelyColors.warning,
                onTap: () {
                  Navigator.pop(context);
                  context.push('/bills/add');
                },
              ),
              _buildActionTile(
                context,
                title: 'Add Wishlist',
                subtitle: 'Scheduled purchase',
                icon: Icons.favorite_border_rounded,
                accentColor: const Color(0xFF6B8FB2),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/shopping/add');
                },
              ),
              _buildActionTile(
                context,
                title: 'Add Asset',
                subtitle: 'Appliance or warranty',
                icon: Icons.kitchen_outlined,
                accentColor: const Color(0xFF9B82B5),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/assets/add');
                },
              ),
              _buildActionTile(
                context,
                title: 'Add Vehicle',
                subtitle: 'Car, bike or scooter',
                icon: Icons.directions_car_outlined,
                accentColor: const Color(0xFFA8896C),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/vehicles/add');
                },
              ),
              _buildActionTile(
                context,
                title: 'Add Reminder',
                subtitle: 'Calendar task',
                icon: Icons.alarm_outlined,
                accentColor: const Color(0xFF5BA390),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/reminders/add');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          border: Border.all(
            color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: accentColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
