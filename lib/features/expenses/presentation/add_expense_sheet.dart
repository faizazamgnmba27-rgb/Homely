import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../data/expenses_repository.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  const AddExpenseSheet({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const AddExpenseSheet(),
    );
  }

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String _category = 'grocery';
  String _paymentMethod = 'UPI';
  DateTime _date = DateTime.now();
  bool _isSaving = false;

  final List<Map<String, String>> _categories = [
    {'id': 'grocery', 'label': 'Groceries & Food'},
    {'id': 'shopping', 'label': 'Shopping & Wishlist'},
    {'id': 'utility', 'label': 'Bills & Utilities'},
    {'id': 'vehicle', 'label': 'Vehicle & Fuel'},
    {'id': 'maintenance', 'label': 'Home Maintenance'},
    {'id': 'healthcare', 'label': 'Healthcare & Medical'},
    {'id': 'other', 'label': 'Other Miscellaneous'},
  ];

  final List<String> _paymentMethods = [
    'UPI',
    'Cash',
    'Credit Card',
    'Debit Card',
    'Net Banking',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final repo = ref.read(expensesRepositoryProvider);
      final paise = CurrencyFormatter.parseToPaise(_amountController.text);
      final now = DateTime.now();

      final newExpense = ExpensesCompanion.insert(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        category: _category,
        amountPaise: paise,
        date: _date,
        paymentMethod: drift.Value(_paymentMethod),
        notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
        linkedEntityType: const drift.Value('manual_daily'),
        createdAt: now,
      );

      await repo.insertExpense(newExpense);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logged ${CurrencyFormatter.formatPaise(paise)} with $_paymentMethod!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving expense: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? HomelyColors.darkCard : HomelyColors.lightCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(HomelySpacing.sheetRadius)),
      ),
      padding: EdgeInsets.fromLTRB(
        HomelySpacing.screenPadding,
        HomelySpacing.md,
        HomelySpacing.screenPadding,
        MediaQuery.of(context).viewInsets.bottom + HomelySpacing.lg,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Record Daily Expense',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Expense Title *',
                hintText: 'e.g. Milk & Bread, Coffee, Hardware store',
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount (₹) *', prefixText: '₹ '),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Required';
                      if (double.tryParse(v) == null) return 'Invalid amount';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    items: _paymentMethods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                    onChanged: (v) => setState(() => _paymentMethod = v!),
                    decoration: const InputDecoration(labelText: 'Payment Mode *'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.sm),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _category,
                    items: _categories.map((c) => DropdownMenuItem(value: c['id'], child: Text(c['label']!))).toList(),
                    onChanged: (v) => setState(() => _category = v!),
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Date'),
                      child: Text(DateFormatter.formatDate(_date)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.sm),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes (Optional)'),
            ),
            const SizedBox(height: HomelySpacing.lg),
            FilledButton(
              onPressed: _isSaving ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save Expense', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
