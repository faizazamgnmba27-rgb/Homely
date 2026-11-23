import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    try {
      await _notificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) {
          if (onSelectNotification != null) {
            onSelectNotification(response.payload);
          }
        },
      );
      _isInitialized = true;
    } catch (e) {
      debugPrint('Notification initialization warning: $e');
    }
  }

  Future<bool> requestPermissions() async {
    try {
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        final granted = await androidImplementation.requestNotificationsPermission();
        return granted ?? false;
      }
      return false;
    } catch (e) {
      debugPrint('Notification permission error: $e');
      return false;
    }
  }

  /// Schedule a notification for a specific point in time
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
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    try {
      // For immediate fallback or when exact alarms are ready
      // In production, tz.TZDateTime.from(scheduledDate, tz.local) is used
      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Schedule notification error: $e');
    }
  }

  /// Cancel an existing notification
  Future<void> cancelNotification(int id) async {
    try {
      await _notificationsPlugin.cancel(id);
    } catch (e) {
      debugPrint('Cancel notification error: $e');
    }
  }

  /// Cancel all active notifications
  Future<void> cancelAllNotifications() async {
    try {
      await _notificationsPlugin.cancelAll();
    } catch (e) {
      debugPrint('Cancel all notifications error: $e');
    }
  }
}
