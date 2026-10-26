// Smoke test for the EMD-TS demo app.
//
// Verifies the dashboard renders, that tapping the demo patient card
// advances the workflow to the Patient screen, and that the compliance
// banner is pinned on the clinical screens.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:em_dts/main.dart';

void main() {
  testWidgets('Dashboard renders, patient card opens Patient screen, '
      'banner on clinical screens', (WidgetTester tester) async {
    await tester.pumpWidget(const EmDtsApp());

    // Dashboard copy.
    expect(find.text('EMD-TS'), findsOneWidget);
    expect(find.text('Device Connected'), findsOneWidget);
    expect(find.text('24'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);

    // The dashboard is not a clinical screen — no compliance banner here.
    expect(find.text('SIMULATED / DEMONSTRATION DATA'), findsNothing);

    // Tap the demo patient card to walk into the workflow.
    await tester.tap(
      find.byKey(const ValueKey<String>('dashboard-patient-card')),
    );
    await tester.pumpAndSettle();

    // The shell's IndexedStack should now show the Patient tab (index 1).
    final IndexedStack shellStack = tester.widget<IndexedStack>(
      find.byType(IndexedStack).first,
    );
    expect(shellStack.index, 1);

    // Patient screen copy.
    expect(find.text('Anita Sharma'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);
    expect(find.text('SpO₂'), findsOneWidget);
    expect(find.text('94%'), findsOneWidget);
    expect(find.text('108 BPM'), findsOneWidget);
    expect(find.text('37.4°C'), findsOneWidget);
    expect(find.text('✓ Captured'), findsNWidgets(2));

    // The compliance banner is pinned on the Patient screen.
    expect(find.text('SIMULATED / DEMONSTRATION DATA'), findsOneWidget);
  });
}
