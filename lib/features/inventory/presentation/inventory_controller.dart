import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../data/inventory_repository.dart';

final allInventoryItemsProvider = StreamProvider<List<InventoryItem>>((ref) {
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo.watchAllItems();
});

final inventoryCategoriesProvider = StreamProvider<List<InventoryCategory>>((ref) {
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo.watchCategories();
});

final selectedInventoryCategoryProvider = StateProvider<String?>((ref) => null);
final inventorySearchQueryProvider = StateProvider<String>((ref) => '');

final filteredInventoryItemsProvider = Provider<AsyncValue<List<InventoryItem>>>((ref) {
  final itemsAsync = ref.watch(allInventoryItemsProvider);
  final selectedCat = ref.watch(selectedInventoryCategoryProvider);
  final searchQuery = ref.watch(inventorySearchQueryProvider).toLowerCase().trim();

  return itemsAsync.whenData((items) {
    return items.where((item) {
      final matchesCategory = selectedCat == null || item.categoryId == selectedCat;
      final matchesSearch = searchQuery.isEmpty ||
          item.name.toLowerCase().contains(searchQuery) ||
          (item.brand?.toLowerCase().contains(searchQuery) ?? false) ||
          (item.storageLocation?.toLowerCase().contains(searchQuery) ?? false);
      return matchesCategory && matchesSearch;
    }).toList();
  });
});
