import 'package:flutter/material.dart';
import 'FortuneResult.dart';

class FortuneHome extends StatelessWidget {
  const FortuneHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("運勢占い")),
      body: Center(
        child: ElevatedButton(
          child: const Text("占う！"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FortuneResult()),
            );
          },
        ),
      ),
    );
  }
}
