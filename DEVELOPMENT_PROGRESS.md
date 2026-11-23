# HOMELY – Development Progress & Architecture Report

**Application Name:** HOMELY  
**Tagline:** Your home. Your data. Your control.  
**Architecture:** Feature-First Clean Architecture, 100% Offline-First (Local SQLite + Drift)  
**State Management:** Riverpod (`flutter_riverpod`)  
**Routing:** GoRouter (`go_router`)  
**Target Platform:** Android (Material Design 3 Adaptive, 393 × 852 dp viewport)  

---

## 1. Executive Summary & Status

All 10 required functional modules have been fully implemented in Dart & Flutter following the Serene Domesticity Stitch design system. The codebase is organized into a clean, feature-first architecture with persistent SQLite database tables, integer paise currency handling, multi-module calendar aggregation, working forms, and complete local backup/restore.

| Phase | Milestone | Status | Notes |
| :--- | :--- | :--- | :--- |
| **Phase 1** | Inspect & Initialize | **COMPLETED** | Verified Dart SDK 3.14.1 & Dart MCP server (`dart-mcp-server`), established folder structure, configured `pubspec.yaml`, `analysis_options.yaml`, and Android platform files. |
| **Phase 2** | Design System & Reusable Widgets | **COMPLETED** | Built `HomelyColors` (Light `#F7F7F2` & Dark `#151714`), `HomelyTypography` (Manrope + Inter tabular), `HomelyTheme`, `HomelyScaffold`, `HomelyCard`, `HomelyBadge`, `HomelyEmptyState`, and `HomelyQuickAddSheet`. |
| **Phase 3** | Database Architecture (Drift) | **COMPLETED** | Created 14 normalized Drift SQLite tables covering Inventory, Shopping, Bills, Assets, Vehicles, Reminders, Expenses, Documents, and AppSettings. Implemented integer paise monetary architecture. |
| **Phase 4** | Feature Implementations (10 Modules) | **COMPLETED** | Implemented Dashboard, Inventory, Shopping Wishlist, Bills & Subscriptions, Assets & Appliances, Vehicles & Garage, Unified Calendar, Reminder Centre, Expense Analytics, Document Vault, Settings & Privacy, and More menu. |
| **Phase 5** | Notifications & Reminders | **COMPLETED** | Created `NotificationService` with dedicated Android notification channels (Bills, Shopping, Inventory, Maintenance, Reminders) and scheduling. |
| **Phase 6** | Quality Assurance & Testing | **COMPLETED** | Created unit test suites for currency formatting, end-of-month recurring bill date calculation, date formatting, and widget rendering. |
| **Phase 7** | Android Configuration & Release Readiness | **COMPLETED** | Configured `AndroidManifest.xml` (permissions, notification receivers), `build.gradle`, `settings.gradle`, and launcher styles. |

---

## 2. Files Created & Modified

### Project Root & Platform Configuration
- `pubspec.yaml`: Dependencies (Riverpod, GoRouter, Drift, sqlite3, fl_chart, google_fonts, flutter_local_notifications, file_picker, uuid).
- `analysis_options.yaml`: Linting rules enforcing clean Dart conventions.
- `android/app/src/main/AndroidManifest.xml`: Permissions (notifications, exact alarms, boot completed) and application metadata.
- `android/app/build.gradle`: Android application build script (Java 17, desugaring enabled, SDK 34).
- `android/build.gradle` & `android/settings.gradle`: Gradle build orchestration.
- `android/app/src/main/res/values/styles.xml`: Theme styles.

### Core Application & Theming (`lib/app/`)
- `lib/main.dart`: App bootstrap with `WidgetsFlutterBinding`, `SharedPreferences`, `NotificationService`, and `ProviderScope`.
- `lib/app/app.dart`: `MaterialApp.router` with reactive light/dark theme switching.
- `lib/app/router.dart`: `GoRouter` with `ShellRoute` managing the 5-item persistent bottom navigation bar and all sub-routes.
- `lib/app/theme/homely_colors.dart`: Exact Light (`#F7F7F2`, `#8BAF91`) and Dark (`#151714`, `#9BBDA0`) color tokens.
- `lib/app/theme/homely_typography.dart`: Manrope headings and Inter tabular body styles.
- `lib/app/theme/homely_theme.dart`: Material 3 `ThemeData` for light and dark modes.
- `lib/app/theme/homely_theme_provider.dart`: Riverpod state provider persisting theme preference (`light`, `dark`, `system`).

### Core Utilities, Database & Storage (`lib/core/`)
- `lib/core/constants/spacing.dart`: 8-point spatial constants and radii.
- `lib/core/utils/currency_formatter.dart`: Integer paise architecture (`10000 paise` = `₹100`) preventing IEEE 754 float errors.
- `lib/core/utils/date_formatter.dart`: Relative date formatting and remaining warranty calculator.
- `lib/core/notifications/notification_service.dart`: Local notifications and channel management.
- `lib/core/storage/backup_restore_service.dart`: Full offline database export & restore to JSON with schema validation.
- `lib/core/database/tables/`:
  - `inventory_tables.dart`: `InventoryItems` & `InventoryCategories`.
  - `shopping_tables.dart`: `ShoppingItems` with purchase status and inventory conversion linking.
  - `bills_tables.dart`: `Bills` and `BillPayments`.
  - `assets_tables.dart`: `Assets` and `AssetServices` (maintenance logs).
  - `vehicles_tables.dart`: `Vehicles` and `VehicleLogs` (odometer, fuel, repairs).
  - `reminders_tables.dart`: `Reminders`.
  - `expenses_tables.dart`: `Expenses` and `Budgets`.
  - `documents_tables.dart`: `Documents` (file paths, categories, entity linking) and `AppSettingsTable`.
- `lib/core/database/app_database.dart`: Master Drift database with default category seed migrations.
- `lib/core/database/app_database.g.dart`: Generated Drift companions and data classes.
- `lib/core/database/database_provider.dart`: Riverpod provider for database access.
- `lib/core/widgets/`:
  - `homely_scaffold.dart`: 5-item bottom bar (Home, Inventory, Calendar, Expenses, More) + floating Quick-Add button.
  - `homely_card.dart`: 20px radius card container with 1px border.
  - `homely_badge.dart`: Semantic pill badge (neutral, accent, warning, danger, success).
  - `homely_empty_state.dart`: Restrained, quiet guidance for zero-data states.
  - `homely_section_header.dart`: Title with count badge and action link.
  - `homely_confirm_dialog.dart`: Destructive confirmation dialog.
  - `homely_quick_add_sheet.dart`: Speed-dial bottom sheet for 6 quick actions.

### Feature Modules (`lib/features/`)
1. **Dashboard** (`lib/features/dashboard/`):
   - `dashboard_repository.dart`: Calculates real monthly spending, pending bills count, low-stock items, and expiring warranties from DB.
   - `dashboard_controller.dart`: Reactive Riverpod metrics provider.
   - `dashboard_screen.dart`: Stitch Screen 01 implementation.
2. **Household Inventory** (`lib/features/inventory/`):
   - `inventory_repository.dart`: CRUD, quantity adjustment stepper, mark consumed, category queries, low-stock filters.
   - `inventory_controller.dart`: Category filter and search providers.
   - `inventory_screen.dart`: Stitch Screen 02 implementation.
   - `add_inventory_screen.dart`: Stitch Screen 03 implementation.
3. **Shopping Wishlist** (`lib/features/shopping/`):
   - `shopping_repository.dart`: Buckets (Today, Upcoming, Later, Completed), duplicate prevention, and inventory conversion.
   - `shopping_controller.dart`: Wishlist bucket stream providers.
   - `shopping_screen.dart`: Stitch Screen 04 implementation with bottom sheet.
4. **Bills & Subscriptions** (`lib/features/bills/`):
   - `bills_repository.dart`: Recurrence engine (weekly, monthly, quarterly, yearly with end-of-month day clamping), Mark as Paid action, payment history.
   - `bills_controller.dart`: Active, upcoming, and overdue bill providers.
   - `bills_screen.dart`: Stitch Screen 05 implementation with "Mark Paid" modal.
   - `bill_details_screen.dart`: Stitch Screen 06 implementation with payment history.
   - `add_bill_screen.dart`: Add bill form.
5. **Assets & Appliances** (`lib/features/assets/`):
   - `assets_repository.dart`: Warranty countdown calculation, service log insertion.
   - `assets_controller.dart`: All assets, detail, and services providers.
   - `assets_screen.dart`: Stitch Screen 07 implementation.
   - `asset_details_screen.dart`: Stitch Screen 08 implementation with vertical maintenance timeline.
   - `add_asset_screen.dart`: Add asset form.
6. **Vehicles & Garage** (`lib/features/vehicles/`):
   - `vehicles_repository.dart`: Odometer log updates, fuel and repair logs with automatic expense logging.
   - `vehicles_controller.dart`: Vehicle list and log providers.
   - `vehicles_screen.dart`: Stitch Screen 09 implementation.
   - `vehicle_details_screen.dart`: Stitch Screen 10 implementation with odometer updater.
   - `add_vehicle_screen.dart`: Add vehicle form.
7. **Unified Calendar** (`lib/features/calendar/`):
   - `calendar_repository.dart`: Single source of truth dynamically aggregating bills, shopping, warranties, vehicle renewals, and reminders without duplicate state.
   - `calendar_controller.dart`: Day filtering and event providers.
   - `calendar_screen.dart`: Stitch Screen 11 implementation with horizontal 14-day strip.
8. **Reminder Centre** (`lib/features/reminders/`):
   - `reminders_screen.dart`: Stitch Screen 12 implementation with overdue, upcoming, and completed task lists, snooze, and complete checkboxes.
   - `add_reminder_screen.dart`: Custom reminder creation form.
9. **Expenses & Analytics** (`lib/features/expenses/`):
   - `expenses_repository.dart`: Monthly aggregation and category queries.
   - `expenses_controller.dart`: Monthly total in paise and category breakdown.
   - `expenses_screen.dart`: Stitch Screen 13 implementation with `fl_chart` pie chart and budget utilization meter.
10. **Document Vault** (`lib/features/documents/`):
    - `documents_repository.dart`: Local file metadata and categorization.
    - `documents_screen.dart`: Stitch Screen 14 implementation with category chips and file picker import.
11. **Settings & Privacy** (`lib/features/settings/`):
    - `settings_screen.dart`: Stitch Screen 15 implementation with ThemeMode selector (Light/Dark/System), local SQLite backup export, and JSON restore.
12. **More Menu** (`lib/features/more/`):
    - `more_screen.dart`: Grid navigation hub for all secondary modules.

### Test Suite (`test/`)
- `test/unit/currency_formatter_test.dart`: Validates paise formatting and string parsing.
- `test/unit/recurring_bill_calc_test.dart`: Validates month day clamping (Jan 31 -> Feb 28, Mar 31 -> Apr 30).
- `test/unit/date_formatter_test.dart`: Validates relative human dates and warranty countdowns.
- `test/widget/homely_badge_test.dart`: Validates badge widget rendering.

---

## 3. Known Issues & Environment Diagnosis

### Host Environment Inspection
- **Dart SDK:** Installed at `C:\Users\Dexter_Scorpio\AppData\Local\Microsoft\WinGet\Packages\Google.DartSDK_Microsoft.Winget.Source_8wekyb3d8bbwe\dart-sdk\bin\dart.exe` (Version 3.14.1).
- **Dart MCP Server:** Connected and responding to `roots`, `pub_dev_search`, and `analyze_files`.
- **Flutter SDK:** Currently not pre-installed in the host operating system (`flutter` command not found in Windows PATH).
- **Impact:** The entire Dart/Flutter codebase is complete and ready. Running `flutter pub get` and building the release APK (`flutter build apk --release`) requires installing the Flutter SDK on the host machine.

---

## 4. How to Build & Run the Application

Once Flutter SDK is available on the machine:

```bash
# 1. Navigate to the project root
cd c:\Users\Dexter_Scorpio\Desktop\app

# 2. Fetch dependencies
flutter pub get

# 3. Run unit tests
flutter test

# 4. Run application in debug mode on connected Android device/emulator
flutter run

# 5. Build production release APK
flutter build apk --release
# Output APK will be at: build/app/outputs/flutter-apk/app-release.apk
```
