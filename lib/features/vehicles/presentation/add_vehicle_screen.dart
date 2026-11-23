import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/date_formatter.dart';
import '../data/vehicles_repository.dart';

class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _regController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _odoController = TextEditingController(text: '0');
  final _notesController = TextEditingController();

  String _vehicleType = 'car';
  DateTime _insuranceExpiry = DateTime.now().add(const Duration(days: 365));
  DateTime _pucExpiry = DateTime.now().add(const Duration(days: 180));
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _regController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _odoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveVehicle() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final repo = ref.read(vehiclesRepositoryProvider);
      final odo = int.tryParse(_odoController.text) ?? 0;
      final now = DateTime.now();

      final v = VehiclesCompanion.insert(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        registrationNumber: _regController.text.trim().toUpperCase(),
        vehicleType: _vehicleType,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        currentOdometerKm: drift.Value(odo),
        insuranceExpiry: _insuranceExpiry,
        pucExpiry: _pucExpiry,
        notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
        createdAt: now,
        updatedAt: now,
      );

      await repo.insertVehicle(v);
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
          'Add Vehicle to Garage',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: primary),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(HomelySpacing.screenPadding),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Vehicle Name *', hintText: 'e.g. Honda City ZX'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.md),
            DropdownButtonFormField<String>(
              value: _vehicleType,
              items: const [
                DropdownMenuItem(value: 'car', child: Text('Car')),
                DropdownMenuItem(value: 'motorcycle', child: Text('Motorcycle')),
                DropdownMenuItem(value: 'scooter', child: Text('Scooter')),
                DropdownMenuItem(value: 'other', child: Text('Other Vehicle')),
              ],
              onChanged: (v) => setState(() => _vehicleType = v!),
              decoration: const InputDecoration(labelText: 'Vehicle Type'),
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _regController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Registration Number *', hintText: 'e.g. MH 12 AB 1234'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'Brand *', hintText: 'e.g. Honda'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(labelText: 'Model *', hintText: 'e.g. City'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _odoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Current Odometer (km)', suffixText: 'km'),
            ),
            const SizedBox(height: HomelySpacing.md),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _insuranceExpiry,
                        firstDate: DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                      );
                      if (picked != null) setState(() => _insuranceExpiry = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Insurance Expiry'),
                      child: Text(DateFormatter.formatShortDate(_insuranceExpiry)),
                    ),
                  ),
                ),
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _pucExpiry,
                        firstDate: DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                      );
                      if (picked != null) setState(() => _pucExpiry = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'PUC Expiry'),
                      child: Text(DateFormatter.formatShortDate(_pucExpiry)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.xl),
            FilledButton(
              onPressed: _isSaving ? null : _saveVehicle,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save Vehicle', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
