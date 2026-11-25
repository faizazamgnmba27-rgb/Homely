import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../../../core/widgets/homely_empty_state.dart';
import '../data/calendar_repository.dart';
import 'calendar_controller.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final selectedDate = ref.watch(selectedCalendarDateProvider);
    final allEventsAsync = ref.watch(unifiedCalendarEventsProvider);
    final selectedEvents = ref.watch(eventsForSelectedDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unified Calendar',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: accent, size: 24),
            tooltip: 'Add Reminder',
            onPressed: () => context.push('/reminders/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Month / Year Header & Day Selector (Horizontal 14 days)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: HomelySpacing.screenPadding, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormatter.formatMonthYear(selectedDate),
                  style: TextStyle(fontFamily: 'Manrope', fontSize: 16, fontWeight: FontWeight.w700, color: primary),
                ),
                TextButton(
                  onPressed: () => ref.read(selectedCalendarDateProvider.notifier).state = DateTime.now(),
                  child: const Text('Today', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),

          // Horizontal 14-day strip
          SizedBox(
            height: 72,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: HomelySpacing.screenPadding),
              itemCount: 14,
              itemBuilder: (context, index) {
                final day = DateTime.now().subtract(const Duration(days: 2)).add(Duration(days: index));
                final isSelected = day.year == selectedDate.year &&
                    day.month == selectedDate.month &&
                    day.day == selectedDate.day;

                final dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1];

                return GestureDetector(
                  onTap: () => ref.read(selectedCalendarDateProvider.notifier).state = day,
                  child: Container(
                    width: 48,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accent
                          : (isDark ? HomelyColors.darkCard : HomelyColors.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? accent
                            : (isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? (isDark ? const Color(0xFF151714) : Colors.white) : secondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${day.day}',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? (isDark ? const Color(0xFF151714) : Colors.white) : primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: HomelySpacing.sm),

          // 2. Events List for Selected Day
          Expanded(
            child: allEventsAsync.when(
              data: (allEvents) {
                if (selectedEvents.isEmpty) {
                  return HomelyEmptyState(
                    icon: Icons.event_available_outlined,
                    title: 'No Events for ${DateFormatter.formatDate(selectedDate)}',
                    message: 'Your schedule is clear! All upcoming bills, groceries, vehicle and appliance services will appear here.',
                    actionLabel: 'Add Reminder',
                    onAction: () => context.push('/reminders/add'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    HomelySpacing.screenPadding,
                    HomelySpacing.xs,
                    HomelySpacing.screenPadding,
                    80,
                  ),
                  itemCount: selectedEvents.length,
                  separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
                  itemBuilder: (context, index) {
                    final event = selectedEvents[index];
                    final color = _getEventColor(event.category);

                    return HomelyCard(
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 44,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: primary,
                                  ),
                                ),
                                if (event.subtitle != null) ...[
                                  const SizedBox(height: 2),
                                  Text(event.subtitle!, style: TextStyle(fontSize: 12, color: secondary)),
                                ],
                              ],
                            ),
                          ),
                          HomelyBadge(
                            label: event.category.toUpperCase(),
                            variant: event.priority == 'high'
                                ? HomelyBadgeVariant.danger
                                : HomelyBadgeVariant.neutral,
                          ),
                          if (event.category == 'custom')
                            PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert, size: 18, color: secondary),
                              onSelected: (val) async {
                                final db = ref.read(appDatabaseProvider);
                                final reminder = await (db.select(db.reminders)
                                      ..where((tbl) => tbl.id.equals(event.id)))
                                    .getSingleOrNull();
                                if (reminder == null) return;

                                if (val == 'edit') {
                                  if (context.mounted) {
                                    await context.push('/reminders/add', extra: reminder);
                                    ref.invalidate(unifiedCalendarEventsProvider);
                                  }
                                } else if (val == 'delete') {
                                  if (context.mounted) {
                                    final confirmed = await HomelyConfirmDialog.show(
                                      context,
                                      title: 'Delete Reminder',
                                      message: 'Are you sure you want to delete "${reminder.title}"?',
                                      isDestructive: true,
                                    );
                                    if (confirmed != true) return;
                                  }
                                  if (reminder.notificationId != null) {
                                    await ref
                                        .read(notificationServiceProvider)
                                        .cancelNotification(reminder.notificationId!);
                                  }
                                  await (db.delete(db.reminders)
                                        ..where((tbl) => tbl.id.equals(reminder.id)))
                                      .go();
                                  ref.invalidate(unifiedCalendarEventsProvider);
                                }
                              },
                              itemBuilder: (ctx) => [
                                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete', style: TextStyle(color: HomelyColors.danger)),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEventColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'bill':
        return Colors.blue;
      case 'shopping':
        return Colors.green;
      case 'warranty':
        return Colors.purple;
      case 'asset_service':
        return Colors.orange;
      case 'vehicle':
        return Colors.brown;
      default:
        return HomelyColors.lightAccent;
    }
  }
}
