import 'package:flutter/material.dart';
import '../../core/constants/spacing.dart';
import 'homely_colors.dart';
import 'homely_typography.dart';

class HomelyTheme {
  static ThemeData get lightTheme {
    final textTheme = HomelyTypography.createTextTheme(isDark: false);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: HomelyColors.lightBg,
      primaryColor: HomelyColors.lightAccent,
      canvasColor: HomelyColors.lightBg,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: HomelyColors.lightAccent,
        onPrimary: Colors.white,
        primaryContainer: HomelyColors.lightAccentContainer,
        onPrimaryContainer: HomelyColors.lightOnAccentContainer,
        secondary: HomelyColors.lightTextSecondary,
        onSecondary: Colors.white,
        surface: HomelyColors.lightCard,
        onSurface: HomelyColors.lightTextPrimary,
        surfaceContainerHighest: HomelyColors.lightSecondaryBg,
        outline: HomelyColors.lightBorder,
        outlineVariant: Color(0xFFE2E4DC),
        error: HomelyColors.danger,
        onError: Colors.white,
      ),
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: HomelyColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.cardRadius),
          side: const BorderSide(color: HomelyColors.lightBorder, width: 1.0),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: HomelyColors.lightBg.withOpacity(0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: const IconThemeData(color: HomelyColors.lightTextPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HomelyColors.lightSecondaryBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          borderSide: const BorderSide(color: HomelyColors.lightBorder, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          borderSide: const BorderSide(color: HomelyColors.lightBorder, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          borderSide: const BorderSide(color: HomelyColors.lightAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: textTheme.bodyMedium,
      ),
      dividerTheme: const DividerThemeData(
        color: HomelyColors.lightBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    final textTheme = HomelyTypography.createTextTheme(isDark: true);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: HomelyColors.darkBg,
      primaryColor: HomelyColors.darkAccent,
      canvasColor: HomelyColors.darkBg,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: HomelyColors.darkAccent,
        onPrimary: Color(0xFF102315),
        primaryContainer: HomelyColors.darkAccentContainer,
        onPrimaryContainer: HomelyColors.darkOnAccentContainer,
        secondary: HomelyColors.darkTextSecondary,
        onSecondary: Color(0xFF151714),
        surface: HomelyColors.darkCard,
        onSurface: HomelyColors.darkTextPrimary,
        surfaceContainerHighest: HomelyColors.darkSecondaryBg,
        outline: HomelyColors.darkBorder,
        outlineVariant: Color(0xFF2C322B),
        error: HomelyColors.danger,
        onError: Colors.white,
      ),
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: HomelyColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.cardRadius),
          side: const BorderSide(color: HomelyColors.darkBorder, width: 1.0),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: HomelyColors.darkBg.withOpacity(0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: const IconThemeData(color: HomelyColors.darkTextPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HomelyColors.darkSecondaryBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          borderSide: const BorderSide(color: HomelyColors.darkBorder, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          borderSide: const BorderSide(color: HomelyColors.darkBorder, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
          borderSide: const BorderSide(color: HomelyColors.darkAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: textTheme.bodyMedium,
      ),
      dividerTheme: const DividerThemeData(
        color: HomelyColors.darkBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
