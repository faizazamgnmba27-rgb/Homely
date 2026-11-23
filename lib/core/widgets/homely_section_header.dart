import 'package:flutter/material.dart';
import '../../app/theme/homely_colors.dart';
import '../constants/spacing.dart';

class HomelySectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int? count;
  final String? actionText;
  final VoidCallback? onAction;

  const HomelySectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.count,
    this.actionText,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    return Padding(
      padding: const EdgeInsets.only(bottom: HomelySpacing.sm, top: HomelySpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primary,
                  letterSpacing: -0.2,
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (actionText != null && onAction != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
