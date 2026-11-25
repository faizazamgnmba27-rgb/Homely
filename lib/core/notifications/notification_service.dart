import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String channelIdBills = 'homely_bills_channel';
  static const String channelNameBills = 'Bills & Payments';
  static const String channelIdShopping = 'homely_shopping_channel';
  static const String channelNameShopping = 'Shopping & Wishlist';
  static const String channelIdInventory = 'homely_inventory_channel';
  static const String channelNameInventory = 'Inventory & Expiry';
  static const String channelIdMaintenance = 'homely_maintenance_channel';
  static const String channelNameMaintenance = 'Appliance & Vehicle Maintenance';
  static const String channelIdReminders = 'homely_reminders_channel';
  static const String channelNameReminders = 'General Reminders';

  bool _isInitialized = false;

  Future<void> initialize({Function(String?)? onSelectNotification}) async {
    if (_isInitialized) return;

    try {
      // Initialize timezone database for zoned scheduling
      tz.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidSettings);

      await _notificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) {
          if (onSelectNotification != null) {
            onSelectNotification(response.payload);
          }
        },
      );

      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        // Create high-importance Android notification channels
        await _createNotificationChannels(androidImplementation);

        // Auto-request notifications permission on Android 13+ (API 33+)
        await androidImplementation.requestNotificationsPermission();
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Notification initialization warning: $e');
    }
  }

  /// Create dedicated Android Notification Channels with high importance and alert sounds
  Future<void> _createNotificationChannels(AndroidFlutterLocalNotificationsPlugin android) async {
    final channels = [
      const AndroidNotificationChannel(
        channelIdReminders,
        channelNameReminders,
        description: 'Scheduled tasks, alerts, and to-do deadlines',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
      const AndroidNotificationChannel(
        channelIdBills,
        channelNameBills,
        description: 'Upcoming bill due dates and recurring subscriptions',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
      const AndroidNotificationChannel(
        channelIdInventory,
        channelNameInventory,
        description: 'Pantry inventory and food expiration warnings',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
      const AndroidNotificationChannel(
        channelIdMaintenance,
        channelNameMaintenance,
        description: 'Appliance and vehicle maintenance servicing',
        importance: Importance.high,
        playSound: true,
      ),
      const AndroidNotificationChannel(
        channelIdShopping,
        channelNameShopping,
        description: 'Shopping list and item reminders',
        importance: Importance.defaultImportance,
      ),
    ];

    for (final channel in channels) {
      try {
        await android.createNotificationChannel(channel);
      } catch (e) {
        debugPrint('Error creating channel ${channel.id}: $e');
      }
    }
  }

  /// Explicitly request permissions from user (Android 13+ POST_NOTIFICATIONS & exact alarms)
  Future<bool> requestPermissions() async {
    try {
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        final granted = await androidImplementation.requestNotificationsPermission();
        try {
          await androidImplementation.requestExactAlarmsPermission();
        } catch (_) {}
        return granted ?? false;
      }
      return false;
    } catch (e) {
      debugPrint('Notification permission error: $e');
      return false;
    }
  }

  /// Check if the system has granted notification permissions to the app
  Future<bool> areNotificationsEnabled() async {
    try {
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        final enabled = await androidImplementation.areNotificationsEnabled();
        return enabled ?? false;
      }
      return false;
    } catch (e) {
      debugPrint('areNotificationsEnabled error: $e');
      return false;
    }
  }

  /// Schedule a notification for a specific future date and time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String channelId,
    required String channelName,
    String? payload,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) {
      // Don't schedule in the past
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Notifications for $channelName in HOMELY',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    try {
      final scheduledTz = tz.TZDateTime.from(scheduledDate, tz.local);

      try {
        // Attempt exact alarm schedule first
        await _notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledTz,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        );
      } catch (alarmException) {
        debugPrint('Exact alarm disallowed, falling back to inexact: $alarmException');
        // Graceful fallback to inexact alarm if exact alarm permission is restricted
        await _notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledTz,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        );
      }
    } catch (e) {
      debugPrint('Schedule notification error: $e');
    }
  }

  /// Show an immediate notification (useful for tests or instant alerts)
  Future<void> showImmediateNotification({
    int id = 999999,
    required String title,
    required String body,
    String channelId = channelIdReminders,
    String channelName = channelNameReminders,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Direct alerts for HOMELY',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    try {
      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Immediate notification error: $e');
    }
  }

  /// Cancel an existing notification by id
  Future<void> cancelNotification(int id) async {
    try {
      await _notificationsPlugin.cancel(id);
    } catch (e) {
      debugPrint('Cancel notification error: $e');
    }
  }

  /// Cancel all active scheduled notifications
  Future<void> cancelAllNotifications() async {
    try {
      await _notificationsPlugin.cancelAll();
    } catch (e) {
      debugPrint('Cancel all notifications error: $e');
    }
  }
}
