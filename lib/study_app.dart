import 'package:flutter/material.dart';

import 'models/study_record.dart';
import 'screens/add_record_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/history_page.dart';

class StudyApp extends StatefulWidget {
  const StudyApp({super.key});

  @override
  State<StudyApp> createState() => _StudyAppState();
}

class _StudyAppState extends State<StudyApp> {
  int currentPageIndex = 0;

  final List<StudyRecord> records = [
    StudyRecord(
      subject: '数学',
      studyMinutes: 60,
      memo: '問題集を進めた',
      studiedAt: DateTime(2026, 7, 13),
    ),
    StudyRecord(
      subject: '英語',
      studyMinutes: 30,
      memo: '単語を復習した',
      studiedAt: DateTime(2026, 7, 12),
    ),
    StudyRecord(
      subject: 'プログラミング',
      studyMinutes: 45,
      memo: 'Flutterの画面を修正した',
      studiedAt: DateTime(2026, 7, 11),
    ),
  ];

  void addRecord(StudyRecord record) {
    setState(() {
      records.insert(0, record);
      currentPageIndex = 0;
    });
  }

  void deleteRecord(StudyRecord record) {
    setState(() {
      records.remove(record);
    });
  }

  void openPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageTitles = ['学習ダッシュボード', '記録を追加', '学習履歴'];
    final pages = [
      DashboardPage(records: records, onOpenAddPage: () => openPage(1)),
      AddRecordPage(onAddRecord: addRecord),
      HistoryPage(records: records, onDeleteRecord: deleteRecord),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[currentPageIndex]),
        centerTitle: false,
      ),
      body: IndexedStack(index: currentPageIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: openPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'ホーム',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: '記録追加',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: '履歴',
          ),
        ],
      ),
    );
  }
}
