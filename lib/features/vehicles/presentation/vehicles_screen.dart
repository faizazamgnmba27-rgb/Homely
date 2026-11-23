import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/homely_badge.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_empty_state.dart';
import 'vehicles_controller.dart';

class VehiclesScreen extends ConsumerWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final vehiclesAsync = ref.watch(allVehiclesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicles & Garage',
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
            tooltip: 'Add Vehicle',
            onPressed: () => context.push('/vehicles/add'),
          ),
        ],
      ),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return HomelyEmptyState(
              icon: Icons.directions_car_outlined,
              title: 'No Vehicles in Garage',
              message: 'Track cars, motorcycles, scooters, odometer logs, PUC renewals, and service records.',
              actionLabel: 'Add First Vehicle',
              onAction: () => context.push('/vehicles/add'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              HomelySpacing.screenPadding,
              HomelySpacing.sm,
              HomelySpacing.screenPadding,
              80,
            ),
            itemCount: vehicles.length,
            separatorBuilder: (_, __) => const SizedBox(height: HomelySpacing.sm),
            itemBuilder: (context, index) {
              final v = vehicles[index];
              final isPucExpired = v.pucExpiry.isBefore(DateTime.now());
              final isInsuranceExpired = v.insuranceExpiry.isBefore(DateTime.now());

              return HomelyCard(
                onTap: () => context.push('/vehicles/${v.id}'),
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
                          child: Icon(_getVehicleIcon(v.vehicleType), color: secondary, size: 22),
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
                                      v.name,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isDark ? HomelyColors.darkBorder : HomelyColors.lightBorder,
                                      ),
                                    ),
                                    child: Text(
                                      v.registrationNumber,
                                      style: TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${v.brand} ${v.model}',
                                style: TextStyle(fontSize: 12, color: secondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: HomelySpacing.sm),

                    // Odometer & Status Badges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.speed, size: 16, color: secondary),
                            const SizedBox(width: 4),
                            Text(
                              '${v.currentOdometerKm} km',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 6,
                          children: [
                            if (isInsuranceExpired)
                              const HomelyBadge(
                                label: 'Ins. Expired',
                                variant: HomelyBadgeVariant.danger,
                              )
                            else
                              HomelyBadge(
                                label: 'Ins: ${DateFormatter.formatShortDate(v.insuranceExpiry)}',
                                variant: HomelyBadgeVariant.neutral,
                              ),
                            if (isPucExpired)
                              const HomelyBadge(
                                label: 'PUC Expired',
                                variant: HomelyBadgeVariant.danger,
                              )
                            else
                              HomelyBadge(
                                label: 'PUC: ${DateFormatter.formatShortDate(v.pucExpiry)}',
                                variant: HomelyBadgeVariant.neutral,
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
    );
  }

  IconData _getVehicleIcon(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return Icons.directions_car;
      case 'motorcycle':
        return Icons.two_wheeler;
      case 'scooter':
        return Icons.moped;
      default:
        return Icons.directions_car_filled;
    }
  }
}
