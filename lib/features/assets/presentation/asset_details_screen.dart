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
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../data/assets_repository.dart';
import 'assets_controller.dart';

class AssetDetailsScreen extends ConsumerWidget {
  final String assetId;

  const AssetDetailsScreen({Key? key, required this.assetId}) : super(key: key);

  void _showAddServiceSheet(BuildContext context, WidgetRef ref) {
    final typeController = TextEditingController(text: 'Routine Service');
    final techController = TextEditingController();
    final costController = TextEditingController();
    final notesController = TextEditingController();
    DateTime serviceDate = DateTime.now();

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
                  Text('Log Service or Repair', style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary)),
                  const SizedBox(height: HomelySpacing.md),
                  TextField(controller: typeController, decoration: const InputDecoration(labelText: 'Service Type *', hintText: 'e.g. Filter Change, Annual Maintenance')),
                  const SizedBox(height: HomelySpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(controller: costController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cost (₹)', prefixText: '₹ ')),
                      ),
                      const SizedBox(width: HomelySpacing.sm),
                      Expanded(
                        child: TextField(controller: techController, decoration: const InputDecoration(labelText: 'Technician')),
                      ),
                    ],
                  ),
                  const SizedBox(height: HomelySpacing.sm),
                  TextField(controller: notesController, decoration: const InputDecoration(labelText: 'Notes')),
                  const SizedBox(height: HomelySpacing.lg),
                  FilledButton(
                    onPressed: () async {
                      final repo = ref.read(assetsRepositoryProvider);
                      final paise = costController.text.isNotEmpty ? CurrencyFormatter.parseToPaise(costController.text) : 0;
                      await repo.insertService(
                        AssetServicesCompanion.insert(
                          id: const Uuid().v4(),
                          assetId: assetId,
                          serviceDate: serviceDate,
                          serviceType: typeController.text.trim(),
                          technicianName: drift.Value(techController.text.trim().isNotEmpty ? techController.text.trim() : null),
                          costPaise: drift.Value(paise),
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
                    child: const Text('Save Service Record', style: TextStyle(fontWeight: FontWeight.w700)),
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

    final assetAsync = ref.watch(assetDetailProvider(assetId));
    final servicesAsync = ref.watch(assetServicesProvider(assetId));
    final repo = ref.watch(assetsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asset Details',
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
                title: 'Delete Asset',
                message: 'Are you sure you want to delete this asset and its service history?',
                isDestructive: true,
              );
              if (confirmed == true) {
                await repo.deleteAsset(assetId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: assetAsync.when(
        data: (asset) {
          if (asset == null) {
            return const Center(child: Text('Asset not found'));
          }

          final isExpired = asset.warrantyExpiryDate.isBefore(DateTime.now());

          return ListView(
            padding: const EdgeInsets.all(HomelySpacing.screenPadding),
            children: [
              // Hero Card
              HomelyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          asset.category.toUpperCase(),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent),
                        ),
                        HomelyBadge(
                          label: isExpired ? 'Expired' : DateFormatter.formatRemainingWarranty(asset.warrantyExpiryDate),
                          variant: isExpired ? HomelyBadgeVariant.danger : HomelyBadgeVariant.accent,
                        ),
                      ],
                    ),
                    const SizedBox(height: HomelySpacing.sm),
                    Text(
                      asset.name,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
                    ),
                    Text(
                      '${asset.brand ?? ''} ${asset.model ?? ''}'.trim(),
                      style: TextStyle(fontSize: 13, color: secondary),
                    ),
                    if (asset.serialNumber != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'S/N: ${asset.serialNumber}',
                        style: TextStyle(fontFamily: 'Courier', fontSize: 11, color: secondary),
                      ),
                    ],
                    const SizedBox(height: HomelySpacing.md),
                    if (asset.purchasePricePaise != null)
                      Text(
                        CurrencyFormatter.formatPaise(asset.purchasePricePaise!),
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: primary,
                        ),
                      ),
                    const SizedBox(height: HomelySpacing.md),
                    const Divider(),
                    const SizedBox(height: HomelySpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Purchase Date', style: TextStyle(fontSize: 12, color: secondary)),
                        Text(DateFormatter.formatDate(asset.purchaseDate), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Warranty Expiry', style: TextStyle(fontSize: 12, color: secondary)),
                        Text(DateFormatter.formatDate(asset.warrantyExpiryDate), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: HomelySpacing.lg),

              // Maintenance & Service Timeline Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Maintenance Timeline',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddServiceSheet(context, ref),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Log Service', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: HomelySpacing.xs),

              // Services List
              servicesAsync.when(
                data: (services) {
                  if (services.isEmpty) {
                    return HomelyCard(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: HomelySpacing.md),
                          child: Text('No service records logged yet.', style: TextStyle(fontSize: 13, color: secondary)),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final s = services[index];
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
                                  child: Icon(Icons.build_outlined, size: 18, color: accent),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s.serviceType,
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primary),
                                    ),
                                    Text(
                                      '${DateFormatter.formatDate(s.serviceDate)} ${s.technicianName != null ? '• ${s.technicianName}' : ''}',
                                      style: TextStyle(fontSize: 11, color: secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (s.costPaise > 0)
                              Text(
                                CurrencyFormatter.formatPaise(s.costPaise),
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: primary,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error loading services: $e'),
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
