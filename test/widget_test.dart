import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sample/main.dart';

void main() {
  testWidgets('main menu shows the three mini apps', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('アプリメニュー'), findsOneWidget);
    expect(find.text('運勢占いアプリ'), findsOneWidget);
    expect(find.text('お絵かきアプリ'), findsOneWidget);
    expect(find.text('3秒チャレンジゲーム'), findsOneWidget);
  });

  testWidgets('fortune app navigates and shows one fortune result', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('運勢占いアプリ'));
    await tester.pumpAndSettle();
    expect(find.text('運勢占い'), findsOneWidget);

    await tester.tap(find.text('占う！'));
    await tester.pumpAndSettle();

    final fortuneResults = ['大吉', '中吉', '小吉', '凶'];
    final hasResult = fortuneResults.any(
      (result) => find.text(result).evaluate().isNotEmpty,
    );
    expect(hasResult, isTrue);
  });

  testWidgets('paint app opens and clear action is available', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('お絵かきアプリ'));
    await tester.pumpAndSettle();

    expect(find.text('お絵かきアプリ'), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
  });

  testWidgets('timer app starts, stops, and shows result screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('3秒チャレンジゲーム'));
    await tester.pumpAndSettle();
    expect(find.text('3秒チャレンジ'), findsOneWidget);

    await tester.tap(find.text('スタート'));
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('ストップ'), findsOneWidget);

    await tester.tap(find.text('ストップ'));
    await tester.pumpAndSettle();
    expect(find.text('結果'), findsOneWidget);
    expect(find.textContaining('あなたの記録:'), findsOneWidget);
  });
}
