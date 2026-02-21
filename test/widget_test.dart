// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:botanic/main.dart';

void main() {
  testWidgets('植物図鑑アプリが起動する', (WidgetTester tester) async {
    await tester.pumpWidget(const BotanicApp());

    expect(find.text('🌿 植物図鑑'), findsOneWidget);
  });
}
