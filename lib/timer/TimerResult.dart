import 'package:flutter/material.dart';

class TimerResult extends StatelessWidget {
  final double resultTime;

  const TimerResult({super.key, required this.resultTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("結果")),
      body: Center(
        child: Text(
          "あなたの記録: ${resultTime.toStringAsFixed(2)} 秒",
          style: const TextStyle(fontSize: 32),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
