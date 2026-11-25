import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/database/app_database.dart';
import '../core/widgets/homely_scaffold.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/inventory/presentation/inventory_screen.dart';
import '../features/inventory/presentation/add_inventory_screen.dart';
import '../features/shopping/presentation/shopping_screen.dart';
import '../features/bills/presentation/bills_screen.dart';
import '../features/bills/presentation/bill_details_screen.dart';
import '../features/bills/presentation/add_bill_screen.dart';
import '../features/assets/presentation/assets_screen.dart';
import '../features/assets/presentation/asset_details_screen.dart';
import '../features/assets/presentation/add_asset_screen.dart';
import '../features/vehicles/presentation/vehicles_screen.dart';
import '../features/vehicles/presentation/vehicle_details_screen.dart';
import '../features/vehicles/presentation/add_vehicle_screen.dart';
import '../features/calendar/presentation/calendar_screen.dart';
import '../features/reminders/presentation/reminders_screen.dart';
import '../features/reminders/presentation/add_reminder_screen.dart';
import '../features/expenses/presentation/expenses_screen.dart';
import '../features/documents/presentation/documents_screen.dart';
import '../features/more/presentation/more_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/timer/presentation/cookie_timer_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final homelyRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    // ShellRoute for persistent 5-item bottom navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        int index = 0;
        final loc = state.uri.path;
        if (loc.startsWith('/inventory')) {
          index = 1;
        } else if (loc.startsWith('/calendar')) {
          index = 2;
        } else if (loc.startsWith('/expenses')) {
          index = 3;
        } else if (loc.startsWith('/more')) {
          index = 4;
        }
        return HomelyScaffold(
          currentIndex: index,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(child: DashboardScreen()),
        ),
        GoRoute(
          path: '/inventory',
          pageBuilder: (context, state) => const NoTransitionPage(child: InventoryScreen()),
        ),
        GoRoute(
          path: '/calendar',
          pageBuilder: (context, state) => const NoTransitionPage(child: CalendarScreen()),
        ),
        GoRoute(
          path: '/expenses',
          pageBuilder: (context, state) => const NoTransitionPage(child: ExpensesScreen()),
        ),
        GoRoute(
          path: '/more',
          pageBuilder: (context, state) => const NoTransitionPage(child: MoreScreen()),
        ),
      ],
    ),

    // Sub-screens outside bottom navigation shell
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/inventory/add',
      builder: (context, state) {
        final item = state.extra;
        return AddInventoryScreen(itemToEdit: item is InventoryItem ? item : null);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/shopping',
      builder: (context, state) => const ShoppingScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/shopping/add',
      builder: (context, state) => const ShoppingScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/bills',
      builder: (context, state) => const BillsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/bills/add',
      builder: (context, state) => const AddBillScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/bills/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return BillDetailsScreen(billId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/assets',
      builder: (context, state) => const AssetsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/assets/add',
      builder: (context, state) => const AddAssetScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/assets/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AssetDetailsScreen(assetId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/vehicles',
      builder: (context, state) => const VehiclesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/vehicles/add',
      builder: (context, state) => const AddVehicleScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/vehicles/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return VehicleDetailsScreen(vehicleId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/reminders',
      builder: (context, state) => const RemindersScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/reminders/add',
      builder: (context, state) {
        final reminder = state.extra;
        return AddReminderScreen(reminderToEdit: reminder is Reminder ? reminder : null);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/documents',
      builder: (context, state) => const DocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/timer',
      builder: (context, state) => const CookieTimerScreen(),
    ),
  ],
);
