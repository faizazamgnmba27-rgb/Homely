import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CalendarRepository(db);
});

class CalendarEvent {
  final String id;
  final String title;
  final String category; // 'bill', 'shopping', 'asset_service', 'warranty', 'vehicle', 'custom'
  final DateTime date;
  final String? subtitle;
  final String priority; // 'high', 'medium', 'low'
  final bool isCompleted;
  final String? relatedEntityId;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    this.subtitle,
    this.priority = 'medium',
    this.isCompleted = false,
    this.relatedEntityId,
  });
}

class CalendarRepository {
  final AppDatabase _db;

  CalendarRepository(this._db);

  /// Aggregates events across all real database modules dynamically without duplicating state
  Stream<List<CalendarEvent>> watchUnifiedEvents() async* {
    // We listen to the database streams
    await for (final _ in _db.select(_db.reminders).watch()) {
      final events = await getUnifiedEvents();
      yield events;
    }
  }

  Future<List<CalendarEvent>> getUnifiedEvents() async {
    final List<CalendarEvent> allEvents = [];

    // 1. Bills
    final bills = await (_db.select(_db.bills)..where((b) => b.isArchived.equals(false))).get();
    for (final b in bills) {
      allEvents.add(
        CalendarEvent(
          id: 'bill_${b.id}',
          title: 'Bill: ${b.name}',
          category: 'bill',
          date: b.dueDate,
          subtitle: '${b.provider} • Due',
          priority: 'high',
          isCompleted: b.status == 'paid',
          relatedEntityId: b.id,
        ),
      );
    }

    // 2. Shopping Items
    final shopping = await (_db.select(_db.shoppingItems)..where((s) => s.status.equals('planned'))).get();
    for (final s in shopping) {
      allEvents.add(
        CalendarEvent(
          id: 'shop_${s.id}',
          title: 'Purchase: ${s.name}',
          category: 'shopping',
          date: s.plannedPurchaseDate,
          subtitle: s.category,
          priority: s.priority,
          isCompleted: s.isConvertedToInventory,
          relatedEntityId: s.id,
        ),
      );
    }

    // 3. Asset Warranties & Services
    final assets = await _db.select(_db.assets).get();
    for (final a in assets) {
      allEvents.add(
        CalendarEvent(
          id: 'war_${a.id}',
          title: 'Warranty Expiry: ${a.name}',
          category: 'warranty',
          date: a.warrantyExpiryDate,
          subtitle: a.brand,
          priority: 'medium',
          relatedEntityId: a.id,
        ),
      );
      if (a.nextServiceDate != null) {
        allEvents.add(
          CalendarEvent(
            id: 'aservice_${a.id}',
            title: 'Service Due: ${a.name}',
            category: 'asset_service',
            date: a.nextServiceDate!,
            subtitle: a.model,
            priority: 'high',
            relatedEntityId: a.id,
          ),
        );
      }
    }

    // 4. Vehicles (Insurance, PUC, Next Service)
    final vehicles = await _db.select(_db.vehicles).get();
    for (final v in vehicles) {
      allEvents.add(
        CalendarEvent(
          id: 'ins_${v.id}',
          title: 'Insurance Renewal: ${v.name}',
          category: 'vehicle',
          date: v.insuranceExpiry,
          subtitle: v.registrationNumber,
          priority: 'high',
          relatedEntityId: v.id,
        ),
      );
      allEvents.add(
        CalendarEvent(
          id: 'puc_${v.id}',
          title: 'PUC Renewal: ${v.name}',
          category: 'vehicle',
          date: v.pucExpiry,
          subtitle: v.registrationNumber,
          priority: 'medium',
          relatedEntityId: v.id,
        ),
      );
    }

    // 5. Custom Reminders
    final customReminders = await _db.select(_db.reminders).get();
    for (final r in customReminders) {
      allEvents.add(
        CalendarEvent(
          id: 'rem_${r.id}',
          title: r.title,
          category: 'custom',
          date: r.dueDate,
          subtitle: r.notes,
          priority: r.priority,
          isCompleted: r.isCompleted,
          relatedEntityId: r.id,
        ),
      );
    }

    // Sort chronologically
    allEvents.sort((a, b) => a.date.compareTo(b.date));
    return allEvents;
  }
}
