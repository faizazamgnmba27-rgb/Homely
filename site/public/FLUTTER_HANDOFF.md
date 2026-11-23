# HOMELY – Flutter Developer Handoff Specification
**Application Name:** HOMELY  
**Tagline:** "Your home. Your data. Your control."  
**Architecture:** Offline-First (Local SQLite / Drift, zero cloud dependency)  
**Target Platform:** Android (Material Design 3 / Adaptive)  

---

## 1. Brand Identity & Design Tokens

### 1.1 Brand Wordmark & Icon
- **Wordmark:** `HOMELY` set in **Manrope Bold (700)** with tracking `0.05em`, uppercase or title case.
- **Icon Symbol:** Geometric minimalist house silhouette created from a clean 1.5–2.0dp stroke: equilateral roof peak transitioning into rounded-corner foundation walls with an inner subtle hearth notch.
- **Android Adaptive Icon:** Monochromatic icon layer (`#8BAF91` foreground on `#F7F7F2` canvas in light mode; `#9BBDA0` on `#151714` in dark mode).

---

## 2. Color System & Material 3 ThemeData

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomelyColors {
  // LIGHT MODE PALETTE (Exact Spec)
  static const Color lightBg = Color(0xFFF7F7F2);
  static const Color lightSecondaryBg = Color(0xFFEFEFE8);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE7E8E1);
  static const Color lightTextPrimary = Color(0xFF20231F);
  static const Color lightTextSecondary = Color(0xFF777B73);
  static const Color lightAccent = Color(0xFF8BAF91);
  static const Color lightAccentContainer = Color(0xFFD6E6D8);
  static const Color lightOnAccentContainer = Color(0xFF1E3B24);

  // DARK MODE PALETTE (Exact Spec - Never simple inversion)
  static const Color darkBg = Color(0xFF151714);
  static const Color darkSecondaryBg = Color(0xFF1D211D);
  static const Color darkCard = Color(0xFF222720);
  static const Color darkBorder = Color(0xFF343A33);
  static const Color darkTextPrimary = Color(0xFFF2F3ED);
  static const Color darkTextSecondary = Color(0xFFA1A79E);
  static const Color darkAccent = Color(0xFF9BBDA0);
  static const Color darkAccentContainer = Color(0xFF2E3D31);
  static const Color darkOnAccentContainer = Color(0xFFD3E7D6);

  // STATUS COLORS (Calibrated Muted Tones)
  static const Color warning = Color(0xFFD48D3B); // Muted warm amber
  static const Color warningContainer = Color(0xFFFDF3E7);
  static const Color danger = Color(0xFFD96B6B);  // Muted coral rose
  static const Color dangerContainer = Color(0xFFFDF0F0);
  static const Color success = Color(0xFF6B9E78); // Forest sage
}

class HomelyTheme {
  static const double cardRadius = 20.0;
  static const double sheetRadius = 28.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: HomelyColors.lightBg,
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
        error: HomelyColors.danger,
        onError: Colors.white,
      ),
      cardTheme: CardTheme(
        color: HomelyColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: HomelyColors.lightBorder, width: 1.0),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: HomelyColors.lightTextPrimary),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.w700, color: HomelyColors.lightTextPrimary, letterSpacing: -0.8),
        headlineLarge: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w600, color: HomelyColors.lightTextPrimary, letterSpacing: -0.4),
        headlineMedium: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w600, color: HomelyColors.lightTextPrimary, letterSpacing: -0.3),
        titleLarge: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w600, color: HomelyColors.lightTextPrimary),
        titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: HomelyColors.lightTextPrimary),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: HomelyColors.lightTextPrimary),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: HomelyColors.lightTextSecondary),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HomelyColors.lightTextPrimary),
        labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: HomelyColors.lightTextSecondary),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: HomelyColors.darkBg,
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
        error: HomelyColors.danger,
        onError: Colors.white,
      ),
      cardTheme: CardTheme(
        color: HomelyColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: HomelyColors.darkBorder, width: 1.0),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: HomelyColors.darkTextPrimary),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.w700, color: HomelyColors.darkTextPrimary, letterSpacing: -0.8),
        headlineLarge: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w600, color: HomelyColors.darkTextPrimary, letterSpacing: -0.4),
        headlineMedium: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w600, color: HomelyColors.darkTextPrimary, letterSpacing: -0.3),
        titleLarge: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w600, color: HomelyColors.darkTextPrimary),
        titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: HomelyColors.darkTextPrimary),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: HomelyColors.darkTextPrimary),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: HomelyColors.darkTextSecondary),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HomelyColors.darkTextPrimary),
        labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: HomelyColors.darkTextSecondary),
      ),
    );
  }
}
```

---

## 3. Standard Spacing & Grid System (8-Point)

```dart
class HomelySpacing {
  static const double xxs = 4.0;
  static const double xs  = 8.0;
  static const double sm  = 12.0;
  static const double md  = 16.0;
  static const double lg  = 20.0;
  static const double xl  = 24.0;
  static const double xxl = 32.0;
  static const double screenMargin = 20.0;
}
```

---

## 4. Reusable Flutter Widgets Blueprint

### 4.1 Master 5-Item Bottom Navigation Bar + FAB
```dart
class HomelyScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onQuickAddPressed;

  const HomelyScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onQuickAddPressed,
  }) : super(key: key);

  @override
  State<HomelyScaffold> createState() => _HomelyScaffoldState();
}

class _HomelyScaffoldState extends State<HomelyScaffold> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgNav = isDark ? HomelyColors.darkCard.withOpacity(0.95) : Colors.white.withOpacity(0.95);
    final borderCol = isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder;

    return Scaffold(
      body: widget.body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onQuickAddPressed,
        elevation: 3,
        backgroundColor: isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: isDark ? const Color(0xFF151714) : Colors.white, size: 28),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgNav,
          border: Border(top: BorderSide(color: borderCol, width: 1)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.inventory_2_outlined, Icons.inventory_2_rounded, 'Inventory'),
                const SizedBox(width: 48), // Space for centered FAB
                _buildNavItem(2, Icons.calendar_today_outlined, Icons.calendar_month_rounded, 'Calendar'),
                _buildNavItem(3, Icons.account_balance_wallet_outlined, Icons.account_balance_wallet_rounded, 'Expenses'),
                _buildNavItem(4, Icons.grid_view_outlined, Icons.grid_view_rounded, 'More'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon, String label) {
    final isSelected = widget.currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeCol = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final inactiveCol = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;

    return InkWell(
      onTap: () => widget.onTabSelected(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? filledIcon : outlineIcon, size: 22, color: isSelected ? activeCol : inactiveCol),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? activeCol : inactiveCol)),
          ],
        ),
      ),
    );
  }
}
```

### 4.2 Status Badge Widget
```dart
enum BadgeVariant { normal, warning, danger, success }

class HomelyBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;

  const HomelyBadge({Key? key, required this.label, this.variant = BadgeVariant.normal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color bg;
    Color fg;

    switch (variant) {
      case BadgeVariant.warning:
        bg = HomelyColors.warning.withOpacity(0.14);
        fg = HomelyColors.warning;
        break;
      case BadgeVariant.danger:
        bg = HomelyColors.danger.withOpacity(0.14);
        fg = HomelyColors.danger;
        break;
      case BadgeVariant.success:
        bg = HomelyColors.success.withOpacity(0.14);
        fg = HomelyColors.success;
        break;
      case BadgeVariant.normal:
      default:
        bg = isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg;
        fg = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
```

---

## 5. Offline-First SQLite Data Schema (Drift / sqflite)

HOMELY is strictly offline-first. No network permissions (`android.permission.INTERNET`) required for core features.

```sql
-- 1. Inventory Items Table
CREATE TABLE inventory_items (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    brand TEXT,
    quantity REAL NOT NULL DEFAULT 1.0,
    unit TEXT NOT NULL DEFAULT 'pcs',
    purchase_date INTEGER,
    expiry_date INTEGER,
    min_stock_level REAL NOT NULL DEFAULT 1.0,
    price REAL,
    storage_location TEXT,
    notes TEXT,
    image_uri TEXT,
    created_at INTEGER NOT NULL
);

-- 2. Shopping Wishlist Table
CREATE TABLE wishlist_items (
    id TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    expected_price REAL,
    quantity INTEGER DEFAULT 1,
    priority TEXT CHECK(priority IN ('high', 'medium', 'low')) DEFAULT 'medium',
    planned_purchase_date INTEGER,
    bucket TEXT CHECK(bucket IN ('today', 'upcoming', 'later', 'completed')) DEFAULT 'upcoming',
    is_completed INTEGER DEFAULT 0,
    created_at INTEGER NOT NULL
);

-- 3. Household Bills & Subscriptions Table
CREATE TABLE bills (
    id TEXT PRIMARY KEY,
    bill_name TEXT NOT NULL,
    category TEXT NOT NULL, -- 'electricity', 'wifi', 'water', 'lpg', 'mobile', 'rent', 'ott', 'insurance'
    provider TEXT NOT NULL,
    amount REAL NOT NULL,
    due_date INTEGER NOT NULL,
    frequency TEXT NOT NULL, -- 'monthly', 'quarterly', 'annual', 'bi-monthly'
    status TEXT CHECK(status IN ('upcoming', 'paid', 'overdue')) DEFAULT 'upcoming',
    receipt_uri TEXT,
    created_at INTEGER NOT NULL
);

-- 4. Bill Payment History Table
CREATE TABLE bill_payments (
    id TEXT PRIMARY KEY,
    bill_id TEXT NOT NULL REFERENCES bills(id) ON DELETE CASCADE,
    paid_amount REAL NOT NULL,
    paid_date INTEGER NOT NULL,
    receipt_attachment TEXT,
    payment_method TEXT
);

-- 5. Household Assets & Appliances Table
CREATE TABLE assets (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL, -- 'refrigerator', 'washing_machine', 'ac', 'tv', 'inverter', etc.
    brand TEXT,
    model TEXT,
    serial_number TEXT,
    purchase_date INTEGER NOT NULL,
    purchase_price REAL,
    warranty_start INTEGER,
    warranty_expiry INTEGER NOT NULL,
    next_service_date INTEGER,
    invoice_uri TEXT,
    warranty_card_uri TEXT,
    image_uri TEXT
);

-- 6. Asset Maintenance Timeline Table
CREATE TABLE maintenance_records (
    id TEXT PRIMARY KEY,
    asset_id TEXT NOT NULL REFERENCES assets(id) ON DELETE CASCADE,
    service_date INTEGER NOT NULL,
    service_type TEXT NOT NULL, -- 'routine', 'repair', 'filter_change'
    technician_name TEXT,
    cost REAL DEFAULT 0.0,
    notes TEXT,
    receipt_uri TEXT
);

-- 7. Vehicles & Garage Table
CREATE TABLE vehicles (
    id TEXT PRIMARY KEY,
    registration_number TEXT NOT NULL UNIQUE,
    vehicle_type TEXT NOT NULL, -- 'car', 'motorcycle', 'scooter'
    brand TEXT NOT NULL,
    model TEXT NOT NULL,
    current_odometer_km INTEGER NOT NULL,
    last_service_date INTEGER,
    next_service_date INTEGER,
    insurance_expiry INTEGER NOT NULL,
    puc_expiry INTEGER NOT NULL,
    image_uri TEXT
);

-- 8. Vehicle Fuel & Service Logs
CREATE TABLE vehicle_logs (
    id TEXT PRIMARY KEY,
    vehicle_id TEXT NOT NULL REFERENCES vehicles(id) ON DELETE CASCADE,
    log_type TEXT CHECK(log_type IN ('fuel', 'service', 'puc_renewal', 'repair')),
    date INTEGER NOT NULL,
    odometer_km INTEGER,
    cost REAL NOT NULL,
    notes TEXT
);

-- 9. Unified Reminders & Calendar Events Table
CREATE TABLE reminders (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    event_type TEXT NOT NULL, -- 'bill', 'shopping', 'asset_service', 'vehicle_service', 'warranty', 'custom'
    due_date INTEGER NOT NULL,
    related_entity_id TEXT, -- foreign reference to bill, asset, or vehicle
    is_completed INTEGER DEFAULT 0,
    snoozed_until INTEGER,
    priority TEXT DEFAULT 'normal'
);

-- 10. Document Vault Metadata Table
CREATE TABLE document_vault (
    id TEXT PRIMARY KEY,
    file_title TEXT NOT NULL,
    category TEXT NOT NULL, -- 'invoice', 'warranty_card', 'insurance', 'vehicle_doc', 'service_receipt', 'other'
    file_uri TEXT NOT NULL,
    file_size_bytes INTEGER,
    mime_type TEXT,
    linked_entity_type TEXT, -- 'asset', 'vehicle', 'bill'
    linked_entity_id TEXT,
    created_at INTEGER NOT NULL
);
```

---

## 6. Currency & Date Formatting Guidelines
- **Currency:** Indian Rupee symbol `₹` (Unicode `\u20B9`). Use `NumberFormat.currency(locale: 'en_IN', symbol: '₹')`.
- **Date Format:** `18 Nov 2026` or `Nov 18, 2026`.
- **Numeric Font:** Always use `GoogleFonts.inter(fontFeatures: [FontFeature.tabularFigures()])` for prices, odometer readings, and counters to prevent jitter.
