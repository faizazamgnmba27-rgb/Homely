import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/homely_colors.dart';
import 'homely_quick_add_sheet.dart';

class HomelyScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const HomelyScaffold({
    Key? key,
    required this.child,
    required this.currentIndex,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/inventory');
        break;
      case 2:
        context.go('/calendar');
        break;
      case 3:
        context.go('/expenses');
        break;
      case 4:
        context.go('/more');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? HomelyColors.darkCard.withOpacity(0.96) : Colors.white.withOpacity(0.96);
    final border = isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => HomelyQuickAddSheet.show(context),
        elevation: 3,
        backgroundColor: accent,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: isDark ? const Color(0xFF151714) : Colors.white,
          size: 28,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bg,
          border: Border(top: BorderSide(color: border, width: 1.0)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, 0, Icons.home_outlined, Icons.home_rounded, 'Home'),
                _buildNavItem(context, 1, Icons.inventory_2_outlined, Icons.inventory_2_rounded, 'Inventory'),
                const SizedBox(width: 48), // Center spacing for elevated FAB
                _buildNavItem(context, 2, Icons.calendar_today_outlined, Icons.calendar_month_rounded, 'Calendar'),
                _buildNavItem(context, 3, Icons.account_balance_wallet_outlined, Icons.account_balance_wallet_rounded, 'Expenses'),
                _buildNavItem(context, 4, Icons.grid_view_outlined, Icons.grid_view_rounded, 'More'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData outlineIcon,
    IconData filledIcon,
    String label,
  ) {
    final isSelected = currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeCol = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final inactiveCol = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;

    return InkWell(
      onTap: () => _onItemTapped(context, index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? filledIcon : outlineIcon,
              size: 22,
              color: isSelected ? activeCol : inactiveCol,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? activeCol : inactiveCol,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
