import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../data/inventory_repository.dart';
import 'inventory_controller.dart';

class AddInventoryScreen extends ConsumerStatefulWidget {
  const AddInventoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddInventoryScreen> createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends ConsumerState<AddInventoryScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _qtyController = TextEditingController(text: '1.0');
  final _minThresholdController = TextEditingController(text: '1.0');
  final _priceController = TextEditingController();
  final _storageLocationController = TextEditingController(text: 'Pantry');
  final _notesController = TextEditingController();

  String _selectedCategory = 'cat_1';
  String _selectedUnit = 'pcs';
  DateTime? _purchaseDate = DateTime.now();
  DateTime? _expiryDate;
  bool _isSaving = false;

  final List<String> _units = ['pcs', 'kg', 'ltr', 'g', 'packets', 'bottles', 'cans'];
  final List<String> _storageLocations = ['Pantry', 'Refrigerator', 'Freezer', 'Kitchen Cabinet', 'Spice Rack', 'Bathroom'];

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _qtyController.dispose();
    _minThresholdController.dispose();
    _priceController.dispose();
    _storageLocationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final repo = ref.read(inventoryRepositoryProvider);
      final qty = double.tryParse(_qtyController.text) ?? 1.0;
      final threshold = double.tryParse(_minThresholdController.text) ?? 1.0;
      final pricePaise = _priceController.text.isNotEmpty
          ? CurrencyFormatter.parseToPaise(_priceController.text)
          : null;

      final now = DateTime.now();
      final newItem = InventoryItemsCompanion.insert(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        categoryId: _selectedCategory,
        brand: drift.Value(_brandController.text.trim().isNotEmpty ? _brandController.text.trim() : null),
        quantity: drift.Value(qty),
        unit: drift.Value(_selectedUnit),
        purchaseDate: drift.Value(_purchaseDate),
        expiryDate: drift.Value(_expiryDate),
        minStockThreshold: drift.Value(threshold),
        approximatePricePaise: drift.Value(pricePaise),
        storageLocation: drift.Value(_storageLocationController.text.trim()),
        notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
        isConsumed: const drift.Value(false),
        createdAt: now,
        updatedAt: now,
      );

      await repo.insertItem(newItem);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_nameController.text} added to inventory!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving item: $e')),
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
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;
    final categoriesAsync = ref.watch(inventoryCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Inventory Item',
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
            // 1. Item Name
            Text('Item Name *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'e.g. Sona Masoori Rice, Milk, Coffee',
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Please enter item name' : null,
            ),
            const SizedBox(height: HomelySpacing.md),

            // 2. Category Dropdown
            Text('Category *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
            const SizedBox(height: 6),
            categoriesAsync.when(
              data: (categories) {
                return DropdownButtonFormField<String>(
                  value: categories.any((c) => c.id == _selectedCategory)
                      ? _selectedCategory
                      : (categories.isNotEmpty ? categories.first.id : null),
                  items: categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                  decoration: const InputDecoration(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading categories'),
            ),
            const SizedBox(height: HomelySpacing.md),

            // 3. Brand
            Text('Brand (Optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(
                hintText: 'e.g. Tata, Amul, Kellogg\'s',
              ),
            ),
            const SizedBox(height: HomelySpacing.md),

            // 4. Quantity and Unit Row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _qtyController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(hintText: '1.0'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Unit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _selectedUnit,
                        items: _units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedUnit = val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Min Stock', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _minThresholdController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(hintText: '1.0'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),

            // 5. Price in ₹ (stored in integer paise)
            Text('Approx Price (₹)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'e.g. 180',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: HomelySpacing.md),

            // 6. Dates: Purchase & Expiry
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Purchase Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _purchaseDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (picked != null) setState(() => _purchaseDate = picked);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                            borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
                            border: Border.all(
                              color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                            ),
                          ),
                          child: Text(
                            _purchaseDate != null ? DateFormatter.formatShortDate(_purchaseDate!) : 'Select Date',
                            style: TextStyle(fontSize: 13, color: primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expiry Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _expiryDate ?? DateTime.now().add(const Duration(days: 30)),
                            firstDate: DateTime.now().subtract(const Duration(days: 30)),
                            lastDate: DateTime.now().add(const Duration(days: 3650)),
                          );
                          if (picked != null) setState(() => _expiryDate = picked);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                            borderRadius: BorderRadius.circular(HomelySpacing.inputRadius),
                            border: Border.all(
                              color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                            ),
                          ),
                          child: Text(
                            _expiryDate != null ? DateFormatter.formatShortDate(_expiryDate!) : 'Optional',
                            style: TextStyle(fontSize: 13, color: _expiryDate != null ? primary : secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),

            // 7. Storage Location
            Text('Storage Location', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: _storageLocations.map((loc) {
                final isSelected = _storageLocationController.text == loc;
                return ChoiceChip(
                  label: Text(loc),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _storageLocationController.text = loc),
                  selectedColor: isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft,
                  labelStyle: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? accent : secondary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: HomelySpacing.md),

            // 8. Notes
            Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'e.g. Bought from Nature\'s Basket, airtight container',
              ),
            ),
            const SizedBox(height: HomelySpacing.xl),

            // Submit Button
            FilledButton(
              onPressed: _isSaving ? null : _saveItem,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HomelySpacing.buttonRadius),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text(
                      'Save to Inventory',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
