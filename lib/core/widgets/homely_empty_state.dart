import 'package:flutter/material.dart';
import '../../app/theme/homely_colors.dart';
import '../constants/spacing.dart';

class HomelyEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const HomelyEmptyState({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HomelySpacing.xl, vertical: HomelySpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                  width: 1.0,
                ),
              ),
              child: Icon(icon, size: 28, color: secondary),
            ),
            const SizedBox(height: HomelySpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
            ),
            const SizedBox(height: HomelySpacing.xs),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: secondary,
                height: 1.4,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: HomelySpacing.lg),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add, size: 18),
                label: Text(actionLabel!),
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HomelySpacing.buttonRadius),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
