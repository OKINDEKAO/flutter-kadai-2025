import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sample/main.dart';

void main() {
  testWidgets('three navigation destinations are shown', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('ホーム'), findsOneWidget);
    expect(find.text('記録追加'), findsOneWidget);
    expect(find.text('履歴'), findsOneWidget);
  });

  testWidgets('dashboard shows summary and chart', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('学習ダッシュボード'), findsOneWidget);
    expect(find.text('135分'), findsOneWidget);
    expect(find.text('3件'), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);
  });

  testWidgets('record can be added from add page', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('記録追加'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('subjectField')), '理科');
    await tester.enterText(find.byKey(const Key('minutesField')), '20');
    await tester.enterText(find.byKey(const Key('memoField')), '復習した');
    await tester.tap(find.byKey(const Key('submitRecordButton')));
    await tester.pumpAndSettle();

    expect(find.text('学習ダッシュボード'), findsOneWidget);
    expect(find.text('155分'), findsOneWidget);
    expect(find.text('4件'), findsOneWidget);
    expect(find.text('理科'), findsWidgets);
  });

  testWidgets('invalid study time shows message', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('記録追加'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('subjectField')), '理科');
    await tester.enterText(find.byKey(const Key('minutesField')), '0');
    await tester.enterText(find.byKey(const Key('memoField')), '復習した');
    await tester.tap(find.byKey(const Key('submitRecordButton')));
    await tester.pump();

    expect(find.text('1から600の数字で入力してください'), findsOneWidget);
  });

  testWidgets('history page shows all records', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('履歴'));
    await tester.pumpAndSettle();

    expect(find.text('学習履歴'), findsOneWidget);
    expect(find.text('3件の記録'), findsOneWidget);
    expect(find.text('数学'), findsOneWidget);
    expect(find.text('英語'), findsOneWidget);
    expect(find.text('プログラミング'), findsOneWidget);
  });

  testWidgets('record can be deleted after confirmation', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('履歴'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('deleteRecordButton_0')));
    await tester.pumpAndSettle();

    expect(find.text('記録を削除しますか？'), findsOneWidget);
    await tester.tap(find.text('削除する'));
    await tester.pumpAndSettle();

    expect(find.text('2件の記録'), findsOneWidget);
    expect(find.text('数学'), findsNothing);
  });
}
