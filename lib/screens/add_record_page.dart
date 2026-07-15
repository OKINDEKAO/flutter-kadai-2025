import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/study_record.dart';

class AddRecordPage extends StatefulWidget {
  final ValueChanged<StudyRecord> onAddRecord;

  const AddRecordPage({super.key, required this.onAddRecord});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final minutesController = TextEditingController();
  final memoController = TextEditingController();

  void submitRecord() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final record = StudyRecord(
      subject: subjectController.text.trim(),
      studyMinutes: int.parse(minutesController.text),
      memo: memoController.text.trim(),
      studiedAt: DateTime.now(),
    );

    widget.onAddRecord(record);
    subjectController.clear();
    minutesController.clear();
    memoController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('勉強記録を追加しました')));
  }

  @override
  void dispose() {
    subjectController.dispose();
    minutesController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '勉強した内容',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      key: const Key('subjectField'),
                      controller: subjectController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: '科目',
                        hintText: '例: 数学',
                        prefixIcon: Icon(Icons.menu_book_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '科目を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('minutesField'),
                      controller: minutesController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: '勉強時間（分）',
                        hintText: '例: 60',
                        prefixIcon: Icon(Icons.schedule),
                      ),
                      validator: (value) {
                        final minutes = int.tryParse(value ?? '');
                        if (minutes == null || minutes < 1 || minutes > 600) {
                          return '1から600の数字で入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('memoField'),
                      controller: memoController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'メモ',
                        hintText: '例: 問題集を進めた',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.edit_note),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'メモを入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        key: const Key('submitRecordButton'),
                        onPressed: submitRecord,
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('記録する'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
