import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../../../core/widgets/homely_empty_state.dart';
import '../data/shopping_repository.dart';
import 'shopping_controller.dart';

class ShoppingScreen extends ConsumerWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  void _showAddItemDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _AddShoppingItemSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final selectedBucket = ref.watch(selectedWishlistBucketProvider);
    final itemsAsync = ref.watch(wishlistItemsByBucketProvider(selectedBucket));
    final repo = ref.watch(shoppingRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Wishlist',
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
            tooltip: 'Add purchase item',
            onPressed: () => _showAddItemDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Bucket Chips: Today / Upcoming / Later / Completed
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: HomelySpacing.screenPadding,
              vertical: HomelySpacing.xs,
            ),
            child: Row(
              children: [
                _buildBucketTab(ref, 'today', 'Today', selectedBucket, accent, secondary, isDark),
                const SizedBox(width: 8),
                _buildBucketTab(ref, 'upcoming', 'Upcoming', selectedBucket, accent, secondary, isDark),
                const SizedBox(width: 8),
                _buildBucketTab(ref, 'later', 'Later', selectedBucket, accent, secondary, isDark),
                const SizedBox(width: 8),
                _buildBucketTab(ref, 'completed', 'Completed', selectedBucket, accent, secondary, isDark),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.xs),

          // 2. Wishlist Items List
          Expanded(
            child: itemsAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return HomelyEmptyState(
                    icon: Icons.favorite_border_rounded,
                    title: 'No $selectedBucket purchases',
                    message: selectedBucket == 'completed'
                        ? 'Items you confirm as purchased will be recorded here.'
                        : 'Plan household purchases, schedule dates, and avoid duplicate stock.',
                    actionLabel: selectedBucket != 'completed' ? 'Add Item to Wishlist' : null,
                    onAction: () => _showAddItemDialog(context, ref),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    HomelySpacing.screenPadding,
                    HomelySpacing.xs,
                    HomelySpacing.screenPadding,
                    80,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
                  itemBuilder: (context, index) {
                    final item = items[index];

                    HomelyBadgeVariant priorityVariant = HomelyBadgeVariant.neutral;
                    if (item.priority == 'high') priorityVariant = HomelyBadgeVariant.danger;
                    if (item.priority == 'medium') priorityVariant = HomelyBadgeVariant.warning;

                    return HomelyCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                child: Icon(Icons.shopping_bag_outlined, color: secondary, size: 22),
                              ),
                              const SizedBox(width: HomelySpacing.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        if (item.expectedPricePaise != null)
                                          Text(
                                            CurrencyFormatter.formatPaise(item.expectedPricePaise!),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: primary,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.category} • ${item.quantity} ${item.unit}',
                                      style: TextStyle(fontSize: 12, color: secondary),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: HomelySpacing.sm),

                          // Badges Row & Actions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                spacing: 6,
                                children: [
                                  HomelyBadge(
                                    label: item.priority.toUpperCase(),
                                    variant: priorityVariant,
                                  ),
                                  HomelyBadge(
                                    label: DateFormatter.formatRelative(item.plannedPurchaseDate),
                                    variant: HomelyBadgeVariant.neutral,
                                    icon: Icons.calendar_today_outlined,
                                  ),
                                  if (item.isConvertedToInventory)
                                    const HomelyBadge(
                                      label: 'In Inventory',
                                      variant: HomelyBadgeVariant.success,
                                      icon: Icons.check,
                                    ),
                                ],
                              ),

                              // Quick actions
                              if (item.status != 'purchased')
                                Row(
                                  children: [
                                    // Postpone button
                                    TextButton(
                                      onPressed: () => repo.postponeItem(item.id, 7),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      child: Text('Postpone', style: TextStyle(fontSize: 12, color: secondary)),
                                    ),
                                    // Confirm Purchased Button
                                    FilledButton.icon(
                                      onPressed: () async {
                                        final confirmed = await HomelyConfirmDialog.show(
                                          context,
                                          title: 'Mark as Purchased',
                                          message: 'Confirm purchase of ${item.name}? This will add it directly to your inventory and log the expense.',
                                        );
                                        if (confirmed == true) {
                                          await repo.markAsPurchasedAndConvertToInventory(item.id);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('${item.name} moved to Inventory!')),
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.check, size: 14),
                                      label: const Text('Purchased', style: TextStyle(fontSize: 12)),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: accent,
                                        foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        visualDensity: VisualDensity.compact,
                                      ),
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
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBucketTab(
    WidgetRef ref,
    String bucketId,
    String label,
    String selectedBucket,
    Color accent,
    Color secondary,
    bool isDark,
  ) {
    final isSelected = selectedBucket == bucketId;
    return Expanded(
      child: InkWell(
        onTap: () => ref.read(selectedWishlistBucketProvider.notifier).state = bucketId,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? accent
                  : (isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? accent : secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddShoppingItemSheet extends ConsumerStatefulWidget {
  const _AddShoppingItemSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<_AddShoppingItemSheet> createState() => _AddShoppingItemSheetState();
}

class _AddShoppingItemSheetState extends ConsumerState<_AddShoppingItemSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController(text: '1.0');
  final _notesController = TextEditingController();

  String _category = 'Groceries';
  String _priority = 'medium';
  DateTime _plannedDate = DateTime.now();

  final List<String> _categories = [
    'Groceries',
    'Kitchen Essentials',
    'Cleaning Supplies',
    'Toiletries',
    'Electronics',
    'Personal Care',
    'Home Decor',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _qtyController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(shoppingRepositoryProvider);
    final now = DateTime.now();
    final pricePaise = _priceController.text.isNotEmpty
        ? CurrencyFormatter.parseToPaise(_priceController.text)
        : null;

    final item = ShoppingItemsCompanion.insert(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      category: _category,
      quantity: drift.Value(double.tryParse(_qtyController.text) ?? 1.0),
      expectedPricePaise: drift.Value(pricePaise),
      priority: drift.Value(_priority),
      plannedPurchaseDate: _plannedDate,
      notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
      status: const drift.Value('planned'),
      createdAt: now,
      updatedAt: now,
    );

    await repo.insertItem(item);
    if (mounted) Navigator.pop(context);
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
            Text('Add to Shopping Wishlist', style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: primary)),
            const SizedBox(height: HomelySpacing.md),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Item Name *', hintText: 'e.g. Organic Olive Oil 1L'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: HomelySpacing.sm),
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
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Est. Price (₹)', prefixText: '₹ '),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.sm),
            Row(
              children: [
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
                const SizedBox(width: HomelySpacing.sm),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _plannedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) setState(() => _plannedDate = picked);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Planned Date'),
                      child: Text(DateFormatter.formatShortDate(_plannedDate)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomelySpacing.lg),
            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Save Purchase Plan', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
