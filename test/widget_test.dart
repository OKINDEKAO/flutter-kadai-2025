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
    expect(find.text('記録一覧'), findsOneWidget);
  });

  testWidgets('sample study record is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('科目: 数学'), findsOneWidget);
    expect(find.text('勉強時間: 60分'), findsOneWidget);
    expect(find.text('メモ: 問題集を進めた'), findsOneWidget);
  });
}
