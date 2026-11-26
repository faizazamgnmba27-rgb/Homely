import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/theme/homely_theme_provider.dart';
import 'core/database/app_database.dart';
import 'core/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize offline persistent preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize notification service safely without blocking app boot
  try {
    final notificationService = NotificationService();
    await notificationService.initialize();
    final db = AppDatabase();
    await notificationService.checkAndTriggerAlerts(db);
    await db.close();
  } catch (e, stack) {
    debugPrint('Notification service initialization non-fatal error: $e\n$stack');
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const HomelyApp(),
    ),
  );
}
