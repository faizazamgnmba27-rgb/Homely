import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../data/shopping_repository.dart';

final selectedWishlistBucketProvider = StateProvider<String>((ref) => 'today'); // 'today', 'upcoming', 'later', 'completed'

final wishlistItemsByBucketProvider = StreamProvider.family<List<ShoppingItem>, String>((ref, bucket) {
  final repo = ref.watch(shoppingRepositoryProvider);
  return repo.watchItemsByBucket(bucket);
});

final allWishlistItemsProvider = StreamProvider<List<ShoppingItem>>((ref) {
  final repo = ref.watch(shoppingRepositoryProvider);
  return repo.watchAllItems();
});
