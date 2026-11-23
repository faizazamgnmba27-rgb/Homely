import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/calendar_repository.dart';

final selectedCalendarDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final unifiedCalendarEventsProvider = FutureProvider<List<CalendarEvent>>((ref) {
  final repo = ref.watch(calendarRepositoryProvider);
  return repo.getUnifiedEvents();
});

final eventsForSelectedDateProvider = Provider<List<CalendarEvent>>((ref) {
  final eventsAsync = ref.watch(unifiedCalendarEventsProvider);
  final selectedDate = ref.watch(selectedCalendarDateProvider);

  return eventsAsync.maybeWhen(
    data: (events) {
      return events.where((e) {
        return e.date.year == selectedDate.year &&
            e.date.month == selectedDate.month &&
            e.date.day == selectedDate.day;
      }).toList();
    },
    orElse: () => [],
  );
});
