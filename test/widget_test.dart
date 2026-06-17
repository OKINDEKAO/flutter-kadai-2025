import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sample/main.dart';

void main() {
  testWidgets('study app top screen is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('勉強記録アプリ'), findsOneWidget);
    expect(find.text('今日の勉強を記録するアプリです'), findsOneWidget);
    expect(find.text('入力する内容'), findsOneWidget);
    expect(find.text('科目'), findsOneWidget);
    expect(find.text('勉強時間'), findsOneWidget);
    expect(find.text('メモ'), findsOneWidget);
    expect(find.text('記録する'), findsOneWidget);
    expect(find.text('記録一覧'), findsOneWidget);
  });

  testWidgets('study form can receive text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(EditableText), findsNWidgets(3));

    await tester.enterText(find.byType(EditableText).at(0), '英語');
    await tester.enterText(find.byType(EditableText).at(1), '30');
    await tester.enterText(find.byType(EditableText).at(2), '単語を覚えた');

    expect(find.text('英語'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('単語を覚えた'), findsOneWidget);
  });

  testWidgets('entered study record is added to the list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(EditableText).at(0), '英語');
    await tester.enterText(find.byType(EditableText).at(1), '30');
    await tester.enterText(find.byType(EditableText).at(2), '単語を覚えた');
    await tester.tap(find.text('記録する'));
    await tester.pump();

    expect(find.text('科目: 英語'), findsOneWidget);
    expect(find.text('勉強時間: 30分'), findsOneWidget);
    expect(find.text('メモ: 単語を覚えた'), findsOneWidget);
  });

  testWidgets('study time must be number', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(EditableText).at(0), '英語');
    await tester.enterText(find.byType(EditableText).at(1), '三十分');
    await tester.enterText(find.byType(EditableText).at(2), '単語を覚えた');
    await tester.tap(find.text('記録する'));
    await tester.pump();

    expect(find.text('勉強時間は数字で入力してください'), findsOneWidget);
    expect(find.text('勉強時間: 三十分分'), findsNothing);
  });

  testWidgets('study record can be deleted', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('科目: 数学'), findsOneWidget);

    await tester.ensureVisible(find.text('削除'));
    await tester.pump();
    await tester.tap(find.text('削除'));
    await tester.pump();

    expect(find.text('科目: 数学'), findsNothing);
  });

  testWidgets('sample study record is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('科目: 数学'), findsOneWidget);
    expect(find.text('勉強時間: 60分'), findsOneWidget);
    expect(find.text('メモ: 問題集を進めた'), findsOneWidget);
  });
}
