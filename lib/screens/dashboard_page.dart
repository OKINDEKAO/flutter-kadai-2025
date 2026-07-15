import 'package:flutter/material.dart';

import '../models/study_record.dart';
import '../widgets/study_bar_chart.dart';

class DashboardPage extends StatelessWidget {
  final List<StudyRecord> records;
  final VoidCallback onOpenAddPage;

  const DashboardPage({
    super.key,
    required this.records,
    required this.onOpenAddPage,
  });

  int get totalMinutes {
    return records.fold(0, (total, record) => total + record.studyMinutes);
  }

  Map<String, int> get subjectTotals {
    final totals = <String, int>{};
    for (final record in records) {
      totals.update(
        record.subject,
        (value) => value + record.studyMinutes,
        ifAbsent: () => record.studyMinutes,
      );
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final averageMinutes = records.isEmpty ? 0 : totalMinutes ~/ records.length;
    final recentRecords = records.take(3).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, constraints.maxWidth),
                  const SizedBox(height: 20),
                  _buildSummary(context, constraints.maxWidth, averageMinutes),
                  const SizedBox(height: 20),
                  _buildChart(context),
                  const SizedBox(height: 24),
                  Text(
                    '最近の記録',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (recentRecords.isEmpty)
                    _buildEmptyState(context)
                  else
                    ...recentRecords.map(
                      (record) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              child: const Icon(Icons.menu_book_outlined),
                            ),
                            title: Text(
                              record.subject,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${record.formattedDate}  ${record.memo}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              '${record.studyMinutes}分',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, double width) {
    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '学習状況',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '記録した内容をまとめて確認できます',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );

    final addButton = FilledButton.icon(
      onPressed: onOpenAddPage,
      icon: const Icon(Icons.add),
      label: const Text('記録を追加'),
    );

    if (width < 600) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, const SizedBox(height: 12), addButton],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: title),
        addButton,
      ],
    );
  }

  Widget _buildSummary(BuildContext context, double width, int averageMinutes) {
    final availableWidth = width > 960 ? 960.0 : width;
    final cardWidth = availableWidth >= 680
        ? (availableWidth - 24) / 3
        : availableWidth;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _summaryCard(
          context,
          width: cardWidth,
          icon: Icons.schedule,
          label: '合計時間',
          value: '$totalMinutes分',
          color: const Color(0xFF087F73),
        ),
        _summaryCard(
          context,
          width: cardWidth,
          icon: Icons.fact_check_outlined,
          label: '記録数',
          value: '${records.length}件',
          color: const Color(0xFF4355B9),
        ),
        _summaryCard(
          context,
          width: cardWidth,
          icon: Icons.insights_outlined,
          label: '平均時間',
          value: '$averageMinutes分',
          color: const Color(0xFFD76B31),
        ),
      ],
    );
  }

  Widget _summaryCard(
    BuildContext context, {
    required double width,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '科目別の勉強時間',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '単位: 分',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            if (subjectTotals.isEmpty)
              const SizedBox(
                height: 220,
                child: Center(child: Text('グラフに表示する記録がありません')),
              )
            else
              StudyBarChart(subjectTotals: subjectTotals),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            const Text('まだ記録がありません'),
          ],
        ),
      ),
    );
  }
}
