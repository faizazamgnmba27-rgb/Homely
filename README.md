# HOMELY — Android Household Management Application

> **Tagline:** *"Your home. Your data. Your control."*

HOMELY is a calm, minimal, and private personal household operating system for Android, built with Flutter, Riverpod, Drift (SQLite), and Material 3. It is designed to be **100% offline-first**: all groceries, bills, warranties, vehicle logs, and documents remain stored securely on-device without cloud sync, accounts, or telemetry.

---

## Architecture & Technology Stack

- **Framework:** Flutter 3+
- **Language:** Dart 3+
- **State Management:** Riverpod (`flutter_riverpod`)
- **Navigation:** GoRouter (`go_router`) with ShellRoute persistent 5-item navigation
- **Local Relational Database:** Drift + SQLite (`sqlite3_flutter_libs`)
- **Notifications:** `flutter_local_notifications`
- **Charts:** `fl_chart`
- **Typography:** `GoogleFonts.manrope` (Headings) and `GoogleFonts.inter` (Body & Tabular currency)
- **Monetary Storage:** Strict integer paise architecture (`100 paise = ₹1.00`), never floating-point currency

---

## 10 Core Functional Modules

1. **Dashboard:** Real-time calculated statistics from SQLite records (monthly household spend, pending bills, low-stock groceries, expiring warranties, and speed-dial actions).
2. **Household Inventory:** Groceries, pantry items, and essentials tracking with category chips, unit selectors, quantity steppers, expiry dates, and low-stock indicators.
3. **Shopping Wishlist:** Scheduled purchase planner grouped into *Today*, *Upcoming*, *Later*, and *Completed* buckets. Features explicit purchase confirmation with automatic inventory conversion and duplicate prevention.
4. **Bills & Subscriptions:** Utility and subscription manager (Electricity, Wi-Fi, Water, LPG, Rent, OTT) with recurrence engine (end-of-month day clamping for the 31st), "Mark as Paid" action, and payment history.
5. **Assets & Appliances:** Electronics and appliances manager with remaining warranty countdown bars, invoice attachments, and a vertical maintenance timeline.
6. **Vehicles & Garage:** Multi-vehicle support (cars, motorcycles, scooters) with manual odometer updating, fuel refill logs, periodic service history, and PUC/insurance expiry reminders.
7. **Unified Calendar:** Central schedule dynamically aggregating events from bills, shopping, warranties, vehicle renewals, and custom reminders without duplicating state.
8. **Reminder Centre:** Task manager with *Overdue*, *Upcoming*, and *Completed* lists, complete checkboxes, and 1-day snooze action.
9. **Expense Analytics:** Financial breakdown by category with interactive `fl_chart` donut/pie charts and monthly budget utilization meters.
10. **Document Vault:** Local safe for invoices, warranty slips, vehicle RC/PUC documents, and receipts stored in app-managed local storage.
11. **Settings & Backup:** Light/Dark/System theme switcher, full JSON/SQLite database export, and validated database restore.

---

## Design System Tokens

### Light Theme
- **Main Background:** `#F7F7F2`
- **Secondary Background:** `#EFEFE8`
- **Cards & Surfaces:** `#FFFFFF` (20px border radius, 1px `#E7E8E1` border)
- **Primary Text:** `#20231F`
- **Secondary Text:** `#777B73`
- **Primary Accent:** `#8BAF91` (Eucalyptus Sage)

### Dark Theme (Calibrated Contrast)
- **Main Background:** `#151714`
- **Secondary Background:** `#1D211D`
- **Cards & Surfaces:** `#222720` (20px border radius, 1px `#343A33` border)
- **Primary Text:** `#F2F3ED`
- **Secondary Text:** `#A1A79E`
- **Primary Accent:** `#9BBDA0` (Luminous Sage)

---

## Project Structure

```
c:\Users\Dexter_Scorpio\Desktop\app\
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
├── DEVELOPMENT_PROGRESS.md
├── android/
│   ├── app/
│   │   ├── build.gradle
│   │   └── src/main/AndroidManifest.xml
│   ├── build.gradle
│   └── settings.gradle
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   ├── router.dart
│   │   └── theme/
│   ├── core/
│   │   ├── constants/
│   │   ├── database/
│   │   ├── notifications/
│   │   ├── storage/
│   │   ├── utils/
│   │   └── widgets/
│   └── features/
│       ├── dashboard/
│       ├── inventory/
│       ├── shopping/
│       ├── bills/
│       ├── assets/
│       ├── vehicles/
│       ├── calendar/
│       ├── reminders/
│       ├── expenses/
│       ├── documents/
│       ├── settings/
│       └── more/
└── test/
    ├── unit/
    └── widget/
```

---

## Setup & Build Instructions

```bash
# 1. Fetch package dependencies
flutter pub get

# 2. Run unit and widget tests
flutter test

# 3. Launch in Android debug mode
flutter run

# 4. Generate release Android APK
flutter build apk --release
# Generated APK will be located at:
# build/app/outputs/flutter-apk/app-release.apk
```
