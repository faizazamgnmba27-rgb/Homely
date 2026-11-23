import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_empty_state.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../data/inventory_repository.dart';
import 'inventory_controller.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final categoriesAsync = ref.watch(inventoryCategoriesProvider);
    final selectedCategory = ref.watch(selectedInventoryCategoryProvider);
    final filteredItemsAsync = ref.watch(filteredInventoryItemsProvider);
    final repo = ref.watch(inventoryRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Household Inventory',
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
            tooltip: 'Add item',
            onPressed: () => context.push('/inventory/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: HomelySpacing.screenPadding,
              vertical: HomelySpacing.xs,
            ),
            child: TextField(
              onChanged: (val) => ref.read(inventorySearchQueryProvider.notifier).state = val,
              decoration: InputDecoration(
                hintText: 'Search pantry, fridge, spices...',
                prefixIcon: Icon(Icons.search, size: 20, color: secondary),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),

          // 2. Category Filters (Horizontal scroll)
          categoriesAsync.when(
            data: (categories) {
              return SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: HomelySpacing.screenPadding),
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = selectedCategory == null;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: const Text('All Items'),
                          selected: isSelected,
                          onSelected: (_) => ref.read(selectedInventoryCategoryProvider.notifier).state = null,
                          selectedColor: isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft,
                          backgroundColor: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? accent : secondary,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                          side: BorderSide(
                            color: isSelected ? accent : (isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder),
                          ),
                        ),
                      );
                    }
                    final cat = categories[index - 1];
                    final isSelected = selectedCategory == cat.id;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cat.name),
                        selected: isSelected,
                        onSelected: (_) => ref.read(selectedInventoryCategoryProvider.notifier).state = cat.id,
                        selectedColor: isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft,
                        backgroundColor: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? accent : secondary,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                        side: BorderSide(
                          color: isSelected ? accent : (isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox(height: 44),
            error: (_, __) => const SizedBox(height: 44),
          ),

          const SizedBox(height: HomelySpacing.xs),

          // 3. Inventory Items List
          Expanded(
            child: filteredItemsAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return HomelyEmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Inventory is Empty',
                    message: 'Track kitchen groceries, pantry stock, cleaning supplies, and expiry alerts.',
                    actionLabel: 'Add Stock Item',
                    onAction: () => context.push('/inventory/add'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    HomelySpacing.screenPadding,
                    HomelySpacing.xs,
                    HomelySpacing.screenPadding,
                    80, // Space for bottom bar
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isLowStock = item.quantity <= item.minStockThreshold;
                    final isExpiringSoon = item.expiryDate != null &&
                        item.expiryDate!.difference(DateTime.now()).inDays <= 3 &&
                        !item.expiryDate!.isBefore(DateTime.now());
                    final isExpired = item.expiryDate != null && item.expiryDate!.isBefore(DateTime.now());

                    return HomelyCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Icon/Avatar
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                                  ),
                                ),
                                child: Icon(Icons.kitchen_outlined, color: secondary, size: 22),
                              ),
                              const SizedBox(width: HomelySpacing.sm),

                              // Name & metadata
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: primary,
                                            ),
                                          ),
                                        ),
                                        if (item.approximatePricePaise != null)
                                          Text(
                                            CurrencyFormatter.formatPaise(item.approximatePricePaise!),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: primary,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        if (item.brand != null && item.brand!.isNotEmpty) ...[
                                          Text(
                                            item.brand!,
                                            style: TextStyle(fontSize: 11, color: secondary),
                                          ),
                                          Text(' • ', style: TextStyle(fontSize: 11, color: secondary)),
                                        ],
                                        if (item.storageLocation != null)
                                          Text(
                                            item.storageLocation!,
                                            style: TextStyle(fontSize: 11, color: secondary),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: HomelySpacing.sm),

                          // Badges & Stock Control Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Status Badges
                              Wrap(
                                spacing: 6,
                                children: [
                                  if (isLowStock)
                                    const HomelyBadge(
                                      label: 'Low Stock',
                                      variant: HomelyBadgeVariant.warning,
                                      icon: Icons.warning_amber_rounded,
                                    ),
                                  if (isExpired)
                                    const HomelyBadge(
                                      label: 'Expired',
                                      variant: HomelyBadgeVariant.danger,
                                      icon: Icons.error_outline,
                                    )
                                  else if (isExpiringSoon)
                                    HomelyBadge(
                                      label: 'Exp ${DateFormatter.formatRelative(item.expiryDate!)}',
                                      variant: HomelyBadgeVariant.warning,
                                      icon: Icons.schedule,
                                    )
                                  else if (item.expiryDate != null)
                                    HomelyBadge(
                                      label: 'Exp: ${DateFormatter.formatShortDate(item.expiryDate!)}',
                                      variant: HomelyBadgeVariant.neutral,
                                    ),
                                ],
                              ),

                              // Quantity Stepper: [-] Qty Unit [+]
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, size: 16),
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () => repo.adjustQuantity(item.id, -1.0),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${item.quantity.toStringAsFixed(item.quantity.truncateToDouble() == item.quantity ? 0 : 1)} ${item.unit}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, size: 16),
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () => repo.adjustQuantity(item.id, 1.0),
                                  ),
                                  PopupMenuButton<String>(
                                    icon: Icon(Icons.more_vert, size: 18, color: secondary),
                                    onSelected: (val) async {
                                      if (val == 'delete') {
                                        final confirmed = await HomelyConfirmDialog.show(
                                          context,
                                          title: 'Delete Item',
                                          message: 'Are you sure you want to remove ${item.name} from your inventory?',
                                          isDestructive: true,
                                        );
                                        if (confirmed == true) {
                                          await repo.deleteItem(item.id);
                                        }
                                      } else if (val == 'consume') {
                                        await repo.markConsumed(item.id);
                                      }
                                    },
                                    itemBuilder: (ctx) => [
                                      const PopupMenuItem(
                                        value: 'consume',
                                        child: Text('Mark as Consumed'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete Item', style: TextStyle(color: HomelyColors.danger)),
                                      ),
                                    ],
                                  ),
                                ],
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
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
