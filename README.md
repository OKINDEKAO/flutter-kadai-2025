# 勉強記録アプリ 改良版

Flutterで作成した勉強記録アプリです。

## できること

- 科目、勉強時間、メモの記録
- 合計時間、記録数、平均時間の表示
- 科目別の勉強時間を棒グラフで表示
- ホーム、記録追加、履歴の画面切り替え
- 入力チェックと記録の削除

## 開発環境

- Flutter 3.35.6
- Dart 3.9.2
- fl_chart 1.2.0

## 起動方法

```powershell
flutter pub get
flutter run -d chrome --web-hostname=localhost --web-port=8081
```

データ保存は未実装のため、アプリを終了すると追加した記録は消えます。
