import 'package:flutter/material.dart';
import '../../app/theme/homely_colors.dart';
import '../constants/spacing.dart';

class HomelyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double radius;

  const HomelyCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.radius = HomelySpacing.cardRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ?? (isDark ? HomelyColors.darkCard : HomelyColors.lightCard);
    final border = borderColor ?? (isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder);

    Widget content = Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.all(HomelySpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border, width: 1.0),
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: (isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent).withOpacity(0.08),
          highlightColor: (isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent).withOpacity(0.04),
          child: content,
        ),
      );
    }

    return content;
  }
}
