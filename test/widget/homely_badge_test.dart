import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homely/core/widgets/homely_badge.dart';

void main() {
  testWidgets('HomelyBadge renders text and icon correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomelyBadge(
            label: 'Low Stock',
            variant: HomelyBadgeVariant.warning,
            icon: Icons.warning_amber_rounded,
          ),
        ),
      ),
    );

    expect(find.text('Low Stock'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });
}
