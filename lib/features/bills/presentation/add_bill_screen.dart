import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../data/bills_repository.dart';

class AddBillScreen extends ConsumerStatefulWidget {
  const AddBillScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends ConsumerState<AddBillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _providerController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String _category = 'Electricity';
  String _recurrence = 'monthly';
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));
  int _reminderDays = 3;
  bool _isSaving = false;

  final List<String> _categories = [
    'Electricity',
    'Wi-Fi',
    'Water',
    'LPG',
    'Mobile',
    'Rent',
    'Maintenance',
    'OTT',
    'Insurance',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _providerController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveBill() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final repo = ref.read(billsRepositoryProvider);
      final paise = CurrencyFormatter.parseToPaise(_amountController.text);
      final now = DateTime.now();

      final bill = BillsCompanion.insert(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        category: _category.toLowerCase(),
        provider: _providerController.text.trim(),
        expectedAmountPaise: paise,
        dueDate: _dueDate,
        recurrence: drift.Value(_recurrence),
        reminderDaysBefore: drift.Value(_reminderDays),
        status: const drift.Value('upcoming'),
        notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
        createdAt: now,
        updatedAt: now,
      );

      await repo.insertBill(bill);

      // Schedule bill due reminder notification
      if (_reminderDays > 0) {
        final reminderDate = _dueDate.subtract(Duration(days: _reminderDays));
        if (reminderDate.isAfter(now)) {
          final notifId = now.millisecondsSinceEpoch.remainder(1000000);
          final notifService = ref.read(notificationServiceProvider);
          await notifService.scheduleNotification(
            id: notifId,
            title: 'Upcoming Bill: ${_nameController.text.trim()}',
            body: 'Due on ${DateFormatter.formatDate(_dueDate)} - Amount: ${_amountController.text.trim()}',
            scheduledDate: reminderDate,
            channelId: NotificationService.channelIdBills,
            channelName: NotificationService.channelNameBills,
          );
        }
      }

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
          'Add Bill or Subscription',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(HomelySpacing.screenPadding),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Bill Name *', hintText: 'e.g. Home Broadband Fiber'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _category,
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _category = v!),
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: TextFormField(
                    controller: _providerController,
                    decoration: const InputDecoration(labelText: 'Provider *', hintText: 'e.g. ACT, Tata Power'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount (₹) *', prefixText: '₹ '),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _recurrence,
                    items: const [
                      DropdownMenuItem(value: 'one_time', child: Text('One-Time')),
                      DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                      DropdownMenuItem(value: 'quarterly', child: Text('Quarterly')),
                      DropdownMenuItem(value: 'yearly', child: Text('Yearly')),
                    ],
                    onChanged: (v) => setState(() => _recurrence = v!),
                    decoration: const InputDecoration(labelText: 'Recurrence'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) setState(() => _dueDate = picked);
              },
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Due Date'),
                child: Text(DateFormatter.formatDate(_dueDate)),
              ),
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Account / Consumer Number / Notes'),
            ),
            const SizedBox(height: HomelySpacing.xl),
            FilledButton(
              onPressed: _isSaving ? null : _saveBill,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save Bill', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
