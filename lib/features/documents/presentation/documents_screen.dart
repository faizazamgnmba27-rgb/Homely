import 'package:drift/drift.dart' as drift;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';
import '../../../core/widgets/homely_empty_state.dart';
import '../data/documents_repository.dart';

final selectedDocumentCategoryProvider = StateProvider<String?>((ref) => null);

final allDocumentsStreamProvider = StreamProvider<List<Document>>((ref) {
  final repo = ref.watch(documentsRepositoryProvider);
  return repo.watchAllDocuments();
});

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  void _showAddDocumentDialog(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final titleController = TextEditingController(text: file.name);
    String category = 'invoice';

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Save to Document Vault'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Document Title')),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: category,
                    items: const [
                      DropdownMenuItem(value: 'invoice', child: Text('Invoice / Bill')),
                      DropdownMenuItem(value: 'warranty_card', child: Text('Warranty Card')),
                      DropdownMenuItem(value: 'insurance', child: Text('Insurance Policy')),
                      DropdownMenuItem(value: 'vehicle_doc', child: Text('Vehicle RC / PUC')),
                      DropdownMenuItem(value: 'service_receipt', child: Text('Service Receipt')),
                      DropdownMenuItem(value: 'other', child: Text('Other Document')),
                    ],
                    onChanged: (v) => setState(() => category = v!),
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                FilledButton(
                  onPressed: () async {
                    final repo = ref.read(documentsRepositoryProvider);
                    final now = DateTime.now();
                    await repo.insertDocument(
                      DocumentsCompanion.insert(
                        id: const Uuid().v4(),
                        title: titleController.text.trim(),
                        category: category,
                        localFilePath: file.path ?? 'app_storage/${file.name}',
                        fileSizeBytes: drift.Value(file.size),
                        mimeType: drift.Value(file.extension),
                        createdAt: now,
                        updatedAt: now,
                      ),
                    );
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Save to Vault'),
                ),
              ],
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

    final documentsAsync = ref.watch(allDocumentsStreamProvider);
    final selectedCategory = ref.watch(selectedDocumentCategoryProvider);
    final repo = ref.watch(documentsRepositoryProvider);

    final categories = [
      {'id': 'invoice', 'name': 'Invoices'},
      {'id': 'warranty_card', 'name': 'Warranty Cards'},
      {'id': 'insurance', 'name': 'Insurance'},
      {'id': 'vehicle_doc', 'name': 'Vehicle RC/PUC'},
      {'id': 'service_receipt', 'name': 'Receipts'},
      {'id': 'other', 'name': 'Other'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document Vault',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: accent, size: 24),
            tooltip: 'Import Document',
            onPressed: () => _showAddDocumentDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Category Chips
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: HomelySpacing.screenPadding, vertical: 4),
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  final isSelected = selectedCategory == null;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('All Documents'),
                      selected: isSelected,
                      onSelected: (_) => ref.read(selectedDocumentCategoryProvider.notifier).state = null,
                      selectedColor: isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft,
                      labelStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? accent : secondary,
                      ),
                    ),
                  );
                }

                final cat = categories[index - 1];
                final isSelected = selectedCategory == cat['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat['name']!),
                    selected: isSelected,
                    onSelected: (_) => ref.read(selectedDocumentCategoryProvider.notifier).state = cat['id'],
                    selectedColor: isDark ? HomelyColors.darkAccentContainer : HomelyColors.lightAccentSoft,
                    labelStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? accent : secondary,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: HomelySpacing.xs),

          // 2. Documents List
          Expanded(
            child: documentsAsync.when(
              data: (docs) {
                final filtered = selectedCategory == null
                    ? docs
                    : docs.where((d) => d.category == selectedCategory).toList();

                if (filtered.isEmpty) {
                  return HomelyEmptyState(
                    icon: Icons.lock_outline,
                    title: 'Vault is Empty',
                    message: 'Safely store invoices, appliance warranty certificates, vehicle RC/PUC, and receipts locally on-device.',
                    actionLabel: 'Import File',
                    onAction: () => _showAddDocumentDialog(context, ref),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    HomelySpacing.screenPadding,
                    HomelySpacing.xs,
                    HomelySpacing.screenPadding,
                    80,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
                  itemBuilder: (context, index) {
                    final doc = filtered[index];
                    return HomelyCard(
                      child: Row(
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
                            child: Icon(Icons.description_outlined, color: secondary, size: 22),
                          ),
                          const SizedBox(width: HomelySpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc.title,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: primary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${DateFormatter.formatDate(doc.createdAt)} • ${doc.category.toUpperCase()}',
                                  style: TextStyle(fontSize: 11, color: secondary),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, size: 18, color: secondary),
                            onSelected: (val) async {
                              if (val == 'delete') {
                                final confirmed = await HomelyConfirmDialog.show(
                                  context,
                                  title: 'Delete Document',
                                  message: 'Remove ${doc.title} from vault?',
                                  isDestructive: true,
                                );
                                if (confirmed == true) {
                                  await repo.deleteDocument(doc.id);
                                }
                              }
                            },
                            itemBuilder: (ctx) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete Document', style: TextStyle(color: HomelyColors.danger)),
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
}
