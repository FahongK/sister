
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sister_skansika/main.dart';

void main() {
  testWidgets('Splash page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SisterSkansikaApp());

    expect(find.text('Sister Skansika'), findsOneWidget);
    expect(find.byIcon(Icons.school_rounded), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('NIS / NIP / Username'), findsOneWidget);
  });
}
