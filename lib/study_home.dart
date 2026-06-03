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

  void addRecord() {
    final subject = subjectController.text.trim();
    final studyTime = timeController.text.trim();
    final memo = memoController.text.trim();

    if (subject.isEmpty || studyTime.isEmpty || memo.isEmpty) {
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
            const SizedBox(height: 12),
            ...records.map((record) => _recordCard(record)),
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

  Widget _recordCard(StudyRecord record) {
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
