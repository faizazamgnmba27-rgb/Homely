import 'package:flutter/material.dart';
import '../../app/theme/homely_colors.dart';

enum HomelyBadgeVariant {
  neutral,
  accent,
  warning,
  danger,
  success,
}

class HomelyBadge extends StatelessWidget {
  final String label;
  final HomelyBadgeVariant variant;
  final IconData? icon;
  final VoidCallback? onTap;

  const HomelyBadge({
    Key? key,
    required this.label,
    this.variant = HomelyBadgeVariant.neutral,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg;
    Color fg;

    switch (variant) {
      case HomelyBadgeVariant.accent:
        bg = isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft;
        fg = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;
        break;
      case HomelyBadgeVariant.warning:
        bg = isDark ? HomelyColors.warningDarkContainer : HomelyColors.warningContainer;
        fg = HomelyColors.warning;
        break;
      case HomelyBadgeVariant.danger:
        bg = isDark ? HomelyColors.dangerDarkContainer : HomelyColors.dangerContainer;
        fg = HomelyColors.danger;
        break;
      case HomelyBadgeVariant.success:
        bg = isDark ? HomelyColors.successDarkContainer : HomelyColors.successContainer;
        fg = HomelyColors.success;
        break;
      case HomelyBadgeVariant.neutral:
      default:
        bg = isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg;
        fg = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
        break;
    }

    Widget content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: content,
      );
    }

    return content;
  }
}
