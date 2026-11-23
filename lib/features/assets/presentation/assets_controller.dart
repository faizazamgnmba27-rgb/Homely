import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../data/assets_repository.dart';

final allAssetsProvider = StreamProvider<List<Asset>>((ref) {
  final repo = ref.watch(assetsRepositoryProvider);
  return repo.watchAllAssets();
});

final assetDetailProvider = StreamProvider.family<Asset?, String>((ref, id) {
  final repo = ref.watch(assetsRepositoryProvider);
  return repo.watchAssetById(id);
});

final assetServicesProvider = StreamProvider.family<List<AssetService>, String>((ref, assetId) {
  final repo = ref.watch(assetsRepositoryProvider);
  return repo.watchServicesForAsset(assetId);
});

final expiringWarrantiesProvider = StreamProvider<List<Asset>>((ref) {
  final repo = ref.watch(assetsRepositoryProvider);
  return repo.watchExpiringWarranties();
});
