import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fermentum_client/app.dart';

void main() {
  testWidgets('Fermentum app shell renders', (tester) async {
    await tester.pumpWidget(const FermentumApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
