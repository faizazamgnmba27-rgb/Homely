import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_empty_state.dart';

final allRemindersProvider = StreamProvider<List<Reminder>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.reminders)..orderBy([(r) => drift.OrderingTerm(expression: r.dueDate)])).watch();
});

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final remindersAsync = ref.watch(allRemindersProvider);
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminder Centre',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: accent, size: 24),
            tooltip: 'Add Reminder',
            onPressed: () => context.push('/reminders/add'),
          ),
        ],
      ),
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return HomelyEmptyState(
              icon: Icons.notifications_none_outlined,
              title: 'No Reminders Active',
              message: 'Create scheduled alerts, task deadlines, and snooze or reschedule them anytime.',
              actionLabel: 'Create Reminder',
              onAction: () => context.push('/reminders/add'),
            );
          }

          final now = DateTime.now();
          final overdue = reminders.where((r) => !r.isCompleted && r.dueDate.isBefore(now)).toList();
          final pending = reminders.where((r) => !r.isCompleted && !r.dueDate.isBefore(now)).toList();
          final completed = reminders.where((r) => r.isCompleted).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              HomelySpacing.screenPadding,
              HomelySpacing.xs,
              HomelySpacing.screenPadding,
              80,
            ),
            children: [
              if (overdue.isNotEmpty) ...[
                Text('Overdue', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: HomelyColors.danger)),
                const SizedBox(height: 8),
                ...overdue.map((r) => _buildReminderTile(context, ref, db, r, primary, secondary, isDark)),
                const SizedBox(height: HomelySpacing.md),
              ],

              if (pending.isNotEmpty) ...[
                Text('Upcoming Tasks', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: primary)),
                const SizedBox(height: 8),
                ...pending.map((r) => _buildReminderTile(context, ref, db, r, primary, secondary, isDark)),
                const SizedBox(height: HomelySpacing.md),
              ],

              if (completed.isNotEmpty) ...[
                Text('Completed', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: secondary)),
                const SizedBox(height: 8),
                ...completed.map((r) => _buildReminderTile(context, ref, db, r, primary, secondary, isDark)),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildReminderTile(
    BuildContext context,
    WidgetRef ref,
    AppDatabase db,
    Reminder r,
    Color primary,
    Color secondary,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: HomelyCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Checkbox(
              value: r.isCompleted,
              activeColor: isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent,
              onChanged: (val) async {
                final isDone = val ?? false;
                await (db.update(db.reminders)..where((tbl) => tbl.id.equals(r.id))).write(
                  RemindersCompanion(
                    isCompleted: drift.Value(isDone),
                    completedAt: drift.Value(isDone ? DateTime.now() : null),
                    updatedAt: drift.Value(DateTime.now()),
                  ),
                );

                // Cancel notification when marked complete
                if (isDone && r.notificationId != null) {
                  await ref.read(notificationServiceProvider).cancelNotification(r.notificationId!);
                }
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.title,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: r.isCompleted ? TextDecoration.lineThrough : null,
                      color: r.isCompleted ? secondary : primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Due ${DateFormatter.formatRelative(r.dueDate)}',
                    style: TextStyle(fontSize: 11, color: secondary),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, size: 18, color: secondary),
              onSelected: (val) async {
                if (val == 'delete') {
                  if (r.notificationId != null) {
                    await ref.read(notificationServiceProvider).cancelNotification(r.notificationId!);
                  }
                  await (db.delete(db.reminders)..where((tbl) => tbl.id.equals(r.id))).go();
                } else if (val == 'snooze') {
                  final newDue = r.dueDate.add(const Duration(days: 1));
                  await (db.update(db.reminders)..where((tbl) => tbl.id.equals(r.id))).write(
                    RemindersCompanion(
                      dueDate: drift.Value(newDue),
                      snoozedUntil: drift.Value(newDue),
                      updatedAt: drift.Value(DateTime.now()),
                    ),
                  );

                  // Reschedule push notification for new date
                  if (r.notificationId != null) {
                    await ref.read(notificationServiceProvider).scheduleNotification(
                      id: r.notificationId!,
                      title: 'Reminder: ${r.title}',
                      body: r.notes ?? 'Snoozed task due now',
                      scheduledDate: newDue,
                      channelId: NotificationService.channelIdReminders,
                      channelName: NotificationService.channelNameReminders,
                    );
                  }
                }
              },
              itemBuilder: (ctx) => [
                const PopupMenuItem(value: 'snooze', child: Text('Snooze 1 Day')),
                const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: HomelyColors.danger))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
