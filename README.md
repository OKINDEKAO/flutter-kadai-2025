# 勉強記録アプリ 開発計画

2026(R08)前期授業用のFlutterアプリです。
3年次に作成したFlutterミニアプリ集を見直し、4年次ではテーマを1つに絞った「勉強記録アプリ」として作り直す方針に変更します。

## 2026/05/13 1日目の作業

- 3年次の提出物を見直した
- 既存アプリの構成を確認した
- 新しいアプリ案を「勉強記録アプリ」に決めた
- PowerPoint資料を作成した
- 今後10回の開発予定を整理した
- 現状アプリの動作確認用にwidget testを整備した

## 現在のコード状態

現時点のアプリ本体は、3年次に作成したミニアプリ集のままです。

- メニュー画面
- 運勢占い
- お絵かき
- 3秒チャレンジ

この既存コードは、Flutterの画面遷移、状態管理、入力処理を理解するための参考として残しています。
次回以降、勉強記録アプリ用の画面へ少しずつ置き換えます。

## 新しいアプリ案

### アプリ名

勉強記録アプリ

### 目的

日々の勉強内容を記録し、あとから学習時間や内容を振り返れるようにする。

### 最低限実装する仕様

最初の目標は、以下の1つの仕様を確実に動かすことです。

- 科目、勉強時間、メモを入力する
- 入力した内容を一覧に表示する

この仕様が動けば、授業条件の「最低限1つの仕様が機能するもの」を満たせます。

## 追加予定の機能

- 記録の削除
- 記録の編集
- 合計勉強時間の表示
- 科目別の絞り込み
- ローカル保存
- UIの改善
- テストの追加

## 開発環境

- Flutter: 3.35.6 stable
- Dart: 3.9.2
- SDK制約: `^3.9.2`
- 開発対象: Flutterアプリ

## 10回の開発予定

| 回 | 日付 | 作業内容 |
|---|---|---|
| 1 | 05/13 | 既存課題の見直し、企画変更、調査、PowerPoint資料作成 |
| 2 | 05/20 | 勉強記録アプリの基本画面を作る |
| 3 | 05/27 | 入力フォームを作る |
| 4 | 06/03 | 入力内容を一覧表示する |
| 5 | 06/10 | 削除機能を追加する |
| 6 | 06/17 | 編集機能または保存機能を調査・実装する |
| 7 | 06/24 | 合計時間や科目別表示を追加する |
| 8 | 07/01 | UI調整とテスト追加を行う |
| 9 | 07/08 | 開発完了、資料更新、提出準備 |
| 10 | 07/15 | 発表 |

## 調査メモ

- Flutterの基本UIは `MaterialApp`、`Scaffold`、`TextField`、`ListView` を中心に学ぶ
- 画面更新は最初は `setState` で理解する
- データ構造は `List` と自作クラスから始める
- 保存機能は後半で `shared_preferences` などを調査する
- テストは `flutter_test` で主要画面の動作を確認する

## 参考URL

- Flutter UI: https://docs.flutter.dev/ui
- Flutter forms: https://docs.flutter.dev/cookbook/forms
- Flutter lists: https://docs.flutter.dev/cookbook/lists/basic-list
- Flutter widget testing: https://docs.flutter.dev/cookbook/testing/widget
- 2024(R06)参考: https://github.com/ayasa06/flutter-mobile-app.git
- 2025(R07)参考: https://github.com/yotarokageyama/flutterMock.git
- 2025(R07)参考: https://github.com/saitouruna/flutter_application_1.git
- 2025(R07)参考: https://github.com/usuiayaka/fluterMock.git

## 実行方法

```bash
flutter pub get
flutter run
```

## テスト

```bash
flutter test
```
