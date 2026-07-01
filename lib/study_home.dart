import 'package:flutter/material.dart';

class StudyHome extends StatefulWidget {
  const StudyHome({super.key});

  @override
  State<StudyHome> createState() => _StudyHomeState();
}

class _StudyHomeState extends State<StudyHome> {
  final subjectController = TextEditingController();
  final timeController = TextEditingController();
  final memoController = TextEditingController();

  final List<StudyRecord> records = [
    const StudyRecord(subject: '数学', studyTime: '60', memo: '問題集を進めた'),
  ];

  int get totalStudyTime {
    int total = 0;

    for (final record in records) {
      total += int.parse(record.studyTime);
    }

    return total;
  }

  void addRecord() {
    final subject = subjectController.text.trim();
    final studyTime = timeController.text.trim();
    final memo = memoController.text.trim();

    if (subject.isEmpty || studyTime.isEmpty || memo.isEmpty) {
      showMessage('入力していないところがあります');
      return;
    }

    if (int.tryParse(studyTime) == null) {
      showMessage('勉強時間は数字で入力してください');
      return;
    }

    setState(() {
      records.add(
        StudyRecord(subject: subject, studyTime: studyTime, memo: memo),
      );
    });

    subjectController.clear();
    timeController.clear();
    memoController.clear();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void deleteRecord(int index) {
    setState(() {
      records.removeAt(index);
    });
  }

  @override
  void dispose() {
    subjectController.dispose();
    timeController.dispose();
    memoController.dispose();
    super.dispose();
  }

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
            _inputField('科目', '例: 数学', subjectController),
            const SizedBox(height: 12),
            _inputField('勉強時間', '例: 60', timeController, isNumber: true),
            const SizedBox(height: 12),
            _inputField('メモ', '例: 問題集を進めた', memoController),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addRecord,
                child: const Text('記録する'),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              '記録一覧',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('合計勉強時間: $totalStudyTime分'),
            const SizedBox(height: 4),
            Text('記録数: ${records.length}件'),
            const SizedBox(height: 12),
            ...List.generate(
              records.length,
              (index) => _recordCard(records[index], index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _recordCard(StudyRecord record, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('科目: ${record.subject}'),
            const SizedBox(height: 8),
            Text('勉強時間: ${record.studyTime}分'),
            const SizedBox(height: 8),
            Text('メモ: ${record.memo}'),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => deleteRecord(index),
                child: const Text('削除'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyRecord {
  final String subject;
  final String studyTime;
  final String memo;

  const StudyRecord({
    required this.subject,
    required this.studyTime,
    required this.memo,
  });
}
