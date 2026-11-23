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
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../data/vehicles_repository.dart';
import 'vehicles_controller.dart';

class VehicleDetailsScreen extends ConsumerWidget {
  final String vehicleId;

  const VehicleDetailsScreen({Key? key, required this.vehicleId}) : super(key: key);

  void _showUpdateOdometerDialog(BuildContext context, WidgetRef ref, int currentKm) {
    final controller = TextEditingController(text: currentKm.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Odometer'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Current Odometer (km)', suffixText: 'km'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final newKm = int.tryParse(controller.text);
              if (newKm != null && newKm >= currentKm) {
                final repo = ref.read(vehiclesRepositoryProvider);
                await repo.updateOdometer(vehicleId, newKm);
              }
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showAddLogSheet(BuildContext context, WidgetRef ref) {
    final costController = TextEditingController();
    final litresController = TextEditingController();
    final odoController = TextEditingController();
    final notesController = TextEditingController();
    String logType = 'fuel'; // 'fuel', 'service', 'puc_renewal', 'repair'

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setState) {
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Log Fuel or Service', style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary)),
                  const SizedBox(height: HomelySpacing.md),
                  DropdownButtonFormField<String>(
                    value: logType,
                    items: const [
                      DropdownMenuItem(value: 'fuel', child: Text('Fuel Refill')),
                      DropdownMenuItem(value: 'service', child: Text('Periodic Service')),
                      DropdownMenuItem(value: 'repair', child: Text('Repair / Parts')),
                      DropdownMenuItem(value: 'puc_renewal', child: Text('PUC Renewal')),
                    ],
                    onChanged: (v) => setState(() => logType = v!),
                    decoration: const InputDecoration(labelText: 'Log Type'),
                  ),
                  const SizedBox(height: HomelySpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: costController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Cost (₹) *', prefixText: '₹ '),
                        ),
                      ),
                      const SizedBox(width: HomelySpacing.sm),
                      Expanded(
                        child: TextField(
                          controller: odoController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Odometer (km)', suffixText: 'km'),
                        ),
                      ),
                    ],
                  ),
                  if (logType == 'fuel') ...[
                    const SizedBox(height: HomelySpacing.sm),
                    TextField(
                      controller: litresController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Litres Filled', suffixText: 'L'),
                    ),
                  ],
                  const SizedBox(height: HomelySpacing.sm),
                  TextField(controller: notesController, decoration: const InputDecoration(labelText: 'Notes / Station')),
                  const SizedBox(height: HomelySpacing.lg),
                  FilledButton(
                    onPressed: () async {
                      final repo = ref.read(vehiclesRepositoryProvider);
                      final paise = CurrencyFormatter.parseToPaise(costController.text);
                      final odo = int.tryParse(odoController.text);
                      final litres = double.tryParse(litresController.text);

                      await repo.insertLog(
                        VehicleLogsCompanion.insert(
                          id: const Uuid().v4(),
                          vehicleId: vehicleId,
                          logType: logType,
                          date: DateTime.now(),
                          costPaise: paise,
                          odometerKm: drift.Value(odo),
                          fuelLitres: drift.Value(litres),
                          notes: drift.Value(notesController.text.trim().isNotEmpty ? notesController.text.trim() : null),
                          createdAt: DateTime.now(),
                        ),
                      );
                      if (context.mounted) Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Save Log', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final vehicleAsync = ref.watch(vehicleDetailProvider(vehicleId));
    final logsAsync = ref.watch(vehicleLogsProvider(vehicleId));
    final repo = ref.watch(vehiclesRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicle Details',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: HomelyColors.danger),
            onPressed: () async {
              final confirmed = await HomelyConfirmDialog.show(
                context,
                title: 'Delete Vehicle',
                message: 'Are you sure you want to remove this vehicle and its logs?',
                isDestructive: true,
              );
              if (confirmed == true) {
                await repo.deleteVehicle(vehicleId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: vehicleAsync.when(
        data: (v) {
          if (v == null) return const Center(child: Text('Vehicle not found'));

          return ListView(
            padding: const EdgeInsets.all(HomelySpacing.screenPadding),
            children: [
              // Hero Vehicle Card
              HomelyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(v.vehicleType.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder),
                          ),
                          child: Text(
                            v.registrationNumber,
                            style: TextStyle(fontFamily: 'Courier', fontSize: 11, fontWeight: FontWeight.w700, color: primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: HomelySpacing.sm),
                    Text(v.name, style: TextStyle(fontFamily: 'Manrope', fontSize: 22, fontWeight: FontWeight.w700, color: primary)),
                    Text('${v.brand} ${v.model}', style: TextStyle(fontSize: 13, color: secondary)),
                    const SizedBox(height: HomelySpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Odometer', style: TextStyle(fontSize: 11, color: secondary)),
                            Text(
                              '${v.currentOdometerKm} km',
                              style: TextStyle(fontFamily: 'Manrope', fontSize: 24, fontWeight: FontWeight.w800, color: primary),
                            ),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _showUpdateOdometerDialog(context, ref, v.currentOdometerKm),
                          icon: const Icon(Icons.edit, size: 14),
                          label: const Text('Update', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: HomelySpacing.md),
                    const Divider(),
                    const SizedBox(height: HomelySpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Insurance Expiry', style: TextStyle(fontSize: 12, color: secondary)),
                        Text(DateFormatter.formatDate(v.insuranceExpiry), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PUC Expiry', style: TextStyle(fontSize: 12, color: secondary)),
                        Text(DateFormatter.formatDate(v.pucExpiry), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: HomelySpacing.lg),

              // Fuel & Service Logs Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logs & Fuel Records', style: TextStyle(fontFamily: 'Manrope', fontSize: 16, fontWeight: FontWeight.w700, color: primary)),
                  TextButton.icon(
                    onPressed: () => _showAddLogSheet(context, ref),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Entry', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: HomelySpacing.xs),

              logsAsync.when(
                data: (logs) {
                  if (logs.isEmpty) {
                    return HomelyCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: HomelySpacing.md),
                          child: Text('No fuel or service logs recorded.', style: TextStyle(fontSize: 13, color: secondary)),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: logs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final l = logs[index];
                      return HomelyCard(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: accent.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    l.logType == 'fuel' ? Icons.local_gas_station : Icons.build,
                                    size: 18,
                                    color: accent,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l.logType == 'fuel'
                                          ? 'Fuel Refill (${l.fuelLitres ?? 0}L)'
                                          : l.logType.toUpperCase(),
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primary),
                                    ),
                                    Text(
                                      '${DateFormatter.formatDate(l.date)} ${l.odometerKm != null ? '• ${l.odometerKm} km' : ''}',
                                      style: TextStyle(fontSize: 11, color: secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              CurrencyFormatter.formatPaise(l.costPaise),
                              style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: primary),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error loading logs: $e'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
