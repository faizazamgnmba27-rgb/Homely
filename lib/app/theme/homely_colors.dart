import 'package:flutter/material.dart';

/// HOMELY Design System Color Tokens
/// Strict adherence to the Serene Domesticity specification.
class HomelyColors {
  // -------------------------------------------------------------
  // LIGHT THEME (Warm Oatmeal Plaster & Eucalyptus Sage)
  // -------------------------------------------------------------
  static const Color lightBg = Color(0xFFF7F7F2);
  static const Color lightSecondaryBg = Color(0xFFEFEFE8);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE7E8E1);
  static const Color lightTextPrimary = Color(0xFF20231F);
  static const Color lightTextSecondary = Color(0xFF777B73);
  static const Color lightAccent = Color(0xFF8BAF91);
  static const Color lightAccentSoft = Color(0xFFE3EDE5);
  static const Color lightAccentContainer = Color(0xFFD6E6D8);
  static const Color lightOnAccentContainer = Color(0xFF1E3B24);

  // -------------------------------------------------------------
  // DARK THEME (Deep Obsidian Slate & Luminous Sage)
  // Not a simple color inversion: carefully calibrated contrast.
  // -------------------------------------------------------------
  static const Color darkBg = Color(0xFF151714);
  static const Color darkSecondaryBg = Color(0xFF1D211D);
  static const Color darkCard = Color(0xFF222720);
  static const Color darkBorder = Color(0xFF343A33);
  static const Color darkTextPrimary = Color(0xFFF2F3ED);
  static const Color darkTextSecondary = Color(0xFFA1A79E);
  static const Color darkAccent = Color(0xFF9BBDA0);
  static const Color darkAccentSoft = Color(0xFF263428);
  static const Color darkAccentContainer = Color(0xFF2E3D31);
  static const Color darkOnAccentContainer = Color(0xFFD3E7D6);

  // -------------------------------------------------------------
  // STATUS & SEMANTIC ACCENTS (Restrained, Muted)
  // -------------------------------------------------------------
  static const Color warning = Color(0xFFD48D3B); // Muted warm amber
  static const Color warningContainer = Color(0xFFFDF3E7);
  static const Color warningDarkContainer = Color(0xFF382A1A);

  static const Color danger = Color(0xFFD96B6B);  // Muted coral rose
  static const Color dangerContainer = Color(0xFFFDF0F0);
  static const Color dangerDarkContainer = Color(0xFF381F1F);

  static const Color success = Color(0xFF6B9E78); // Forest sage
  static const Color successContainer = Color(0xFFEBF4ED);
  static const Color successDarkContainer = Color(0xFF1D3323);

  // Category Accent Helpers (Calm, earthy tones)
  static const Color catGroceries = Color(0xFF7E9F85);
  static const Color catUtilities = Color(0xFF708CA6);
  static const Color catAssets = Color(0xFF9484A8);
  static const Color catVehicles = Color(0xFFA38372);
  static const Color catHealth = Color(0xFFA67777);
}
