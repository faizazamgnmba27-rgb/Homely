import 'package:flutter/material.dart';
import '../../app/theme/homely_colors.dart';
import '../constants/spacing.dart';

class HomelyConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final VoidCallback onConfirm;

  const HomelyConfirmDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
    required this.onConfirm,
  }) : super(key: key);

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => HomelyConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        onConfirm: () => Navigator.of(ctx).pop(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final confirmBg = isDestructive ? HomelyColors.danger : (isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent);

    return Dialog(
      backgroundColor: isDark ? HomelyColors.darkCard : HomelyColors.lightCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HomelySpacing.sheetRadius),
        side: BorderSide(
          color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(HomelySpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
            const SizedBox(height: HomelySpacing.xs),
            Text(
              message,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: secondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: HomelySpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelLabel,
                    style: TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: HomelySpacing.xs),
                FilledButton(
                  onPressed: onConfirm,
                  style: FilledButton.styleFrom(
                    backgroundColor: confirmBg,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(HomelySpacing.buttonRadius),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  ),
                  child: Text(
                    confirmLabel,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
