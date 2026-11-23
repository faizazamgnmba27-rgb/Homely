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
import '../data/assets_repository.dart';

class AddAssetScreen extends ConsumerStatefulWidget {
  const AddAssetScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends ConsumerState<AddAssetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialController = TextEditingController();
  final _priceController = TextEditingController();
  final _sellerController = TextEditingController();
  final _notesController = TextEditingController();

  String _category = 'refrigerator';
  DateTime _purchaseDate = DateTime.now();
  DateTime _warrantyExpiryDate = DateTime.now().add(const Duration(days: 365 * 2));
  DateTime? _nextServiceDate;
  bool _isSaving = false;

  final List<Map<String, String>> _categories = [
    {'id': 'refrigerator', 'name': 'Refrigerator'},
    {'id': 'washing_machine', 'name': 'Washing Machine'},
    {'id': 'ac', 'name': 'Air Conditioner'},
    {'id': 'tv', 'name': 'Television'},
    {'id': 'microwave', 'name': 'Microwave'},
    {'id': 'water_purifier', 'name': 'Water Purifier'},
    {'id': 'inverter', 'name': 'Inverter & Battery'},
    {'id': 'laptop', 'name': 'Laptop'},
    {'id': 'smartphone', 'name': 'Smartphone'},
    {'id': 'other', 'name': 'Other Equipment'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _serialController.dispose();
    _priceController.dispose();
    _sellerController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveAsset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final repo = ref.read(assetsRepositoryProvider);
      final pricePaise = _priceController.text.isNotEmpty ? CurrencyFormatter.parseToPaise(_priceController.text) : null;
      final now = DateTime.now();

      final asset = AssetsCompanion.insert(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        category: _category,
        brand: drift.Value(_brandController.text.trim().isNotEmpty ? _brandController.text.trim() : null),
        model: drift.Value(_modelController.text.trim().isNotEmpty ? _modelController.text.trim() : null),
        serialNumber: drift.Value(_serialController.text.trim().isNotEmpty ? _serialController.text.trim() : null),
        purchaseDate: _purchaseDate,
        purchasePricePaise: drift.Value(pricePaise),
        warrantyExpiryDate: _warrantyExpiryDate,
        seller: drift.Value(_sellerController.text.trim().isNotEmpty ? _sellerController.text.trim() : null),
        nextServiceDate: drift.Value(_nextServiceDate),
        notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
        createdAt: now,
        updatedAt: now,
      );

      await repo.insertAsset(asset);
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
          'Add Appliance or Asset',
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
              decoration: const InputDecoration(labelText: 'Asset Name *', hintText: 'e.g. LG French Door Refrigerator'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.md),
            DropdownButtonFormField<String>(
              value: _category,
              items: _categories.map((c) => DropdownMenuItem(value: c['id'], child: Text(c['name']!))).toList(),
              onChanged: (v) => setState(() => _category = v!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'Brand', hintText: 'e.g. LG, Daikin'),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(labelText: 'Model Number'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price Paid (₹)', prefixText: '₹ '),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: TextFormField(
                    controller: _serialController,
                    decoration: const InputDecoration(labelText: 'Serial Number'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _purchaseDate,
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _purchaseDate = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Purchase Date'),
                      child: Text(DateFormatter.formatShortDate(_purchaseDate)),
                    ),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _warrantyExpiryDate,
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
                      );
                      if (picked != null) setState(() => _warrantyExpiryDate = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Warranty Expiry *'),
                      child: Text(DateFormatter.formatShortDate(_warrantyExpiryDate)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _sellerController,
              decoration: const InputDecoration(labelText: 'Seller / Store', hintText: 'e.g. Reliance Digital, Croma'),
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: HomelySpacing.xl),
            FilledButton(
              onPressed: _isSaving ? null : _saveAsset,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save Asset', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
