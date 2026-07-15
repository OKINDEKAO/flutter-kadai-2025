import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StudyBarChart extends StatelessWidget {
  final Map<String, int> subjectTotals;

  const StudyBarChart({super.key, required this.subjectTotals});

  @override
  Widget build(BuildContext context) {
    final entries = subjectTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final visibleEntries = entries.take(6).toList();
    final highestValue = visibleEntries.map((entry) => entry.value).reduce(max);
    final maxY = ((highestValue / 30).ceil() * 30 + 30).toDouble();
    final colors = [
      const Color(0xFF087F73),
      const Color(0xFF4355B9),
      const Color(0xFFD76B31),
      const Color(0xFFB23A68),
      const Color(0xFF5B7F3A),
      const Color(0xFF59636E),
    ];

    return SizedBox(
      height: 260,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Theme.of(context).colorScheme.outlineVariant,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= visibleEntries.length) {
                    return const SizedBox.shrink();
                  }
                  final subject = visibleEntries[index].key;
                  final label = subject.length > 5
                      ? '${subject.substring(0, 5)}…'
                      : subject;
                  return SideTitleWidget(
                    meta: meta,
                    space: 8,
                    child: Text(label, style: const TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => const Color(0xFF263238),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final entry = visibleEntries[group.x];
                return BarTooltipItem(
                  '${entry.key}\n${entry.value}分',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          barGroups: List.generate(visibleEntries.length, (index) {
            final entry = visibleEntries[index];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  width: 28,
                  color: colors[index % colors.length],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            );
          }),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      ),
    );
  }
}
