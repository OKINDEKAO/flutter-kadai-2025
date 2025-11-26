import 'package:flutter/material.dart';
import 'dart:math';

class FortuneResult extends StatelessWidget {
  const FortuneResult({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> results = ["大吉", "中吉", "小吉", "凶"];
    final randomResult = results[Random().nextInt(results.length)];

    return Scaffold(
      appBar: AppBar(title: const Text("占い結果")),
      body: Center(
        child: Text(
          randomResult,
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
