import 'package:flutter/material.dart';

class StudyHome extends StatelessWidget {
  const StudyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('勉強記録アプリ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('今日の勉強を記録するアプリです', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 24),
            const Text(
              '入力する内容',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _infoBox('科目', '例: 数学'),
            _infoBox('勉強時間', '例: 60分'),
            _infoBox('メモ', '例: 問題集を進めた'),
            const SizedBox(height: 28),
            const Text(
              '記録一覧',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('科目: 数学'),
                    SizedBox(height: 8),
                    Text('勉強時間: 60分'),
                    SizedBox(height: 8),
                    Text('メモ: 問題集を進めた'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String title, String example) {
    return Card(
      child: ListTile(title: Text(title), subtitle: Text(example)),
    );
  }
}
