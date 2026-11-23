import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homely_colors.dart';

class HomelyTypography {
  static TextTheme createTextTheme({required bool isDark}) {
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;

    return TextTheme(
      // Display: Section Heroes & Wordmark
      displayLarge: GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
        letterSpacing: -0.8,
        height: 1.25,
      ),
      displayMedium: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: primary,
        letterSpacing: -0.6,
        height: 1.25,
      ),

      // Headlines: Card headers, module titles
      headlineLarge: GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: -0.4,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: -0.3,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: -0.2,
        height: 1.35,
      ),

      // Titles: Group headers, list tile titles
      titleLarge: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.35,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),

      // Body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.45,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.4,
      ),

      // Labels & Buttons
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
        letterSpacing: 0.2,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: secondary,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Tabular numeral style for currency, counters, and dates to prevent visual jitter
  static TextStyle tabularFigures({
    required BuildContext context,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;

    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? defaultColor,
      fontFeatures: const [FontFeature.tabularFigures()],
      letterSpacing: -0.2,
    );
  }
}
