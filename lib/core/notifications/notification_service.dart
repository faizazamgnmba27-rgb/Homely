import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../database/app_database.dart';

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

  /// Schedule recurring alerts for shopping wishlist every 2 hours between 9:00 AM and 9:00 PM
  /// (9 AM, 11 AM, 1 PM, 3 PM, 5 PM, 7 PM, 9 PM)
  Future<void> scheduleShoppingWishlistAlerts({required int pendingCount}) async {
    // 7 notification slots across the day (9am, 11am, 1pm, 3pm, 5pm, 7pm, 9pm)
    final hours = [9, 11, 13, 15, 17, 19, 21];
    
    // Base notification ID offset for wishlist alerts
    const baseId = 700000;

    if (pendingCount <= 0) {
      for (int i = 0; i < hours.length; i++) {
        await cancelNotification(baseId + i);
      }
      return;
    }

    final androidDetails = const AndroidNotificationDetails(
      channelIdShopping,
      channelNameShopping,
      channelDescription: 'Shopping list and wishlist reminders',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );
    final notificationDetails = NotificationDetails(android: androidDetails);

    final now = DateTime.now();

    for (int i = 0; i < hours.length; i++) {
      final hour = hours[i];
      DateTime target = DateTime(now.year, now.month, now.day, hour, 0);
      if (target.isBefore(now)) {
        target = target.add(const Duration(days: 1));
      }

      final scheduledTz = tz.TZDateTime.from(target, tz.local);
      try {
        await _notificationsPlugin.zonedSchedule(
          baseId + i,
          'Shopping Wishlist Reminder 🛍️',
          'You have $pendingCount planned purchase${pendingCount > 1 ? 's' : ''} in your wishlist.',
          scheduledTz,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time, // Repeats daily at this exact time
        );
      } catch (e) {
        debugPrint('Error scheduling 2-hour shopping reminder ($hour:00): $e');
      }
    }
  }

  /// Schedule notification for food/pantry item 15 days before expiry
  Future<void> scheduleFoodExpiryAlert({
    required int id,
    required String itemName,
    required DateTime expiryDate,
  }) async {
    final alertDate = expiryDate.subtract(const Duration(days: 15));
    final now = DateTime.now();

    DateTime scheduledDate;
    if (alertDate.isAfter(now)) {
      scheduledDate = alertDate;
    } else if (expiryDate.isAfter(now)) {
      // If already within 15 days, alert tomorrow morning 9:00 AM or in 5 minutes
      scheduledDate = now.add(const Duration(hours: 1));
    } else {
      // Already expired, do not schedule
      return;
    }

    final diffDays = expiryDate.difference(now).inDays;
    final bodyText = diffDays <= 15
        ? '$itemName is expiring in $diffDays day${diffDays != 1 ? 's' : ''}! Use it soon.'
        : '$itemName will expire in 15 days (${expiryDate.day}/${expiryDate.month}/${expiryDate.year}).';

    await scheduleNotification(
      id: id,
      title: 'Food Expiry Warning 🍎',
      body: bodyText,
      scheduledDate: scheduledDate,
      channelId: channelIdInventory,
      channelName: channelNameInventory,
    );
  }

  /// Cancel all active scheduled notifications
  Future<void> cancelAllNotifications() async {
    try {
      await _notificationsPlugin.cancelAll();
    } catch (e) {
      debugPrint('Cancel all notifications error: $e');
    }
  }

  /// Inspect local database and trigger immediate notifications for:
  /// - Non-empty shopping wishlist (never triggers when empty)
  /// - Inventory items near expiry (within 15 days)
  /// - Vehicle PUC / Insurance near expiry (within 15 days)
  /// - Appliance / Asset service due (within 7 days)
  /// - Bills due soon or overdue (within 3 days)
  Future<void> checkAndTriggerAlerts(AppDatabase db) async {
    final now = DateTime.now();

    try {
      // 1. Shopping / Wishlist (only trigger if non-empty)
      final shoppingItems = await db.select(db.shoppingItems).get();
      final pendingWishlist = shoppingItems.where((i) => i.status == 'planned').toList();
      if (pendingWishlist.isNotEmpty) {
        await showImmediateNotification(
          id: 710001,
          title: 'Shopping Wishlist Reminder 🛍️',
          body: 'You have ${pendingWishlist.length} planned purchase${pendingWishlist.length > 1 ? 's' : ''} in your wishlist.',
          channelId: channelIdShopping,
          channelName: channelNameShopping,
        );
      }
      await scheduleShoppingWishlistAlerts(pendingCount: pendingWishlist.length);

      // 2. Inventory Near Expiry (within 15 days)
      final inventoryItems = await db.select(db.inventoryItems).get();
      final expiryThreshold = now.add(const Duration(days: 15));
      final expiringItems = inventoryItems
          .where((i) => i.expiryDate != null && !i.expiryDate!.isAfter(expiryThreshold))
          .toList();
      if (expiringItems.isNotEmpty) {
        await showImmediateNotification(
          id: 710002,
          title: 'Near Expiry Alert 🍎',
          body: '${expiringItems.length} inventory item${expiringItems.length > 1 ? 's' : ''} expiring soon (${expiringItems.first.name}).',
          channelId: channelIdInventory,
          channelName: channelNameInventory,
        );
      }

      // 3. Vehicle PUC / Insurance Near Expiry (within 15 days)
      final vehicles = await db.select(db.vehicles).get();
      final vehicleAlerts = vehicles.where((v) {
        final pucSoon = v.pucExpiryDate != null && !v.pucExpiryDate!.isAfter(expiryThreshold);
        final insSoon = v.insuranceExpiryDate != null && !v.insuranceExpiryDate!.isAfter(expiryThreshold);
        return pucSoon || insSoon;
      }).toList();
      if (vehicleAlerts.isNotEmpty) {
        await showImmediateNotification(
          id: 710003,
          title: 'PUC / Insurance Near Expiry 🚗',
          body: '${vehicleAlerts.length} vehicle${vehicleAlerts.length > 1 ? 's' : ''} (${vehicleAlerts.first.name}) ha${vehicleAlerts.length > 1 ? 've' : 's'} a renewal due soon.',
          channelId: channelIdMaintenance,
          channelName: channelNameMaintenance,
        );
      }

      // 4. Asset / Appliance Service Due (within 7 days)
      final assets = await db.select(db.assets).get();
      final serviceThreshold = now.add(const Duration(days: 7));
      final serviceDue = assets
          .where((a) => a.nextServiceDate != null && !a.nextServiceDate!.isAfter(serviceThreshold))
          .toList();
      if (serviceDue.isNotEmpty) {
        await showImmediateNotification(
          id: 710004,
          title: 'Service Due Alert 🔧',
          body: '${serviceDue.length} appliance${serviceDue.length > 1 ? 's' : ''} (${serviceDue.first.name}) due for service.',
          channelId: channelIdMaintenance,
          channelName: channelNameMaintenance,
        );
      }

      // 5. Bills Due Soon or Overdue (within 3 days)
      final bills = await db.select(db.bills).get();
      final billThreshold = now.add(const Duration(days: 3));
      final billsDue = bills
          .where((b) => b.status != 'paid' && !b.dueDate.isAfter(billThreshold))
          .toList();
      if (billsDue.isNotEmpty) {
        await showImmediateNotification(
          id: 710005,
          title: 'Bill Due Reminder 💳',
          body: '${billsDue.length} bill${billsDue.length > 1 ? 's' : ''} (${billsDue.first.title}) due soon or overdue.',
          channelId: channelIdBills,
          channelName: channelNameBills,
        );
      }
    } catch (e) {
      debugPrint('checkAndTriggerAlerts error: $e');
    }
  }
}
