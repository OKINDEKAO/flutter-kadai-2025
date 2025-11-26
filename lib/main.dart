import 'package:flutter/material.dart';
import 'fortune/FortuneHome.dart';
import 'paint/PaintPage.dart';
import 'timer/TimerHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("アプリメニュー")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildMenuButton(
              context,
              label: "運勢占いアプリ",
              page: const FortuneHome(),
            ),
            const SizedBox(height: 20),
            buildMenuButton(context, label: "お絵かきアプリ", page: const PaintPage()),
            const SizedBox(height: 20),
            buildMenuButton(
              context,
              label: "3秒チャレンジゲーム",
              page: const TimerHome(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
    BuildContext context, {
    required String label,
    required Widget page,
  }) {
    return SizedBox(
      width: double.infinity, // 横幅いっぱい
      height: 80, // 押しやすい高さ
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}
