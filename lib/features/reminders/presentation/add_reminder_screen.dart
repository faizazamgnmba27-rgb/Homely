import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/date_formatter.dart';

class AddReminderScreen extends ConsumerStatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends ConsumerState<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _dueDate = DateTime.now().add(const Duration(hours: 4));
  String _priority = 'medium';
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final db = ref.read(appDatabaseProvider);
      final notificationService = ref.read(notificationServiceProvider);
      final now = DateTime.now();
      final notificationId = now.millisecondsSinceEpoch.remainder(1000000);

      await db.into(db.reminders).insert(
            RemindersCompanion.insert(
              id: const Uuid().v4(),
              title: _titleController.text.trim(),
              eventType: const drift.Value('custom'),
              dueDate: _dueDate,
              priority: drift.Value(_priority),
              notificationId: drift.Value(notificationId),
              notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
              createdAt: now,
              updatedAt: now,
            ),
          );

      // Schedule offline push notification for this reminder
      await notificationService.scheduleNotification(
        id: notificationId,
        title: 'Reminder: ${_titleController.text.trim()}',
        body: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : 'Scheduled task due now',
        scheduledDate: _dueDate,
        channelId: NotificationService.channelIdReminders,
        channelName: NotificationService.channelNameReminders,
      );

      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Reminder',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: primary),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(HomelySpacing.screenPadding),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task or Reminder *', hintText: 'e.g. Call RO technician for filter change'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dueDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                      );
                      if (picked != null) {
                        setState(() {
                          _dueDate = DateTime(picked.year, picked.month, picked.day, _dueDate.hour, _dueDate.minute);
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Due Date'),
                      child: Text(DateFormatter.formatDate(_dueDate)),
                    ),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _priority,
                    items: const [
                      DropdownMenuItem(value: 'high', child: Text('High Priority')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium Priority')),
                      DropdownMenuItem(value: 'low', child: Text('Low Priority')),
                    ],
                    onChanged: (v) => setState(() => _priority = v!),
                    decoration: const InputDecoration(labelText: 'Priority'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Notes (Optional)'),
            ),
            const SizedBox(height: HomelySpacing.xl),
            FilledButton(
              onPressed: _isSaving ? null : _saveReminder,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save Reminder', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
