import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dashboard_repository.dart';

final dashboardMetricsProvider = FutureProvider<DashboardMetrics>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.getDashboardMetrics();
});
