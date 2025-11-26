import 'package:flutter/material.dart';
import 'TimerResult.dart';
import 'dart:async';

class TimerHome extends StatefulWidget {
  const TimerHome({super.key});

  @override
  State<TimerHome> createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> {
  late Timer _timer;
  double time = 0;
  bool isRunning = false;

  void start() {
    setState(() {
      time = 0;
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        time += 0.01;
      });
    });
  }

  void stop() {
    _timer.cancel();
    setState(() => isRunning = false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TimerResult(resultTime: time)),
    );
  }

  @override
  void dispose() {
    if (isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("3秒チャレンジ")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time.toStringAsFixed(2), style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 40),
            ElevatedButton(
              child: Text(isRunning ? "ストップ" : "スタート"),
              onPressed: () {
                if (isRunning) {
                  stop();
                } else {
                  start();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
