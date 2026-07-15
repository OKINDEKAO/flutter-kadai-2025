class StudyRecord {
  final String subject;
  final int studyMinutes;
  final String memo;
  final DateTime studiedAt;

  const StudyRecord({
    required this.subject,
    required this.studyMinutes,
    required this.memo,
    required this.studiedAt,
  });

  String get formattedDate {
    final month = studiedAt.month.toString().padLeft(2, '0');
    final day = studiedAt.day.toString().padLeft(2, '0');
    return '${studiedAt.year}/$month/$day';
  }
}
