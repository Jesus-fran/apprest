import 'package:flutter/material.dart';

class Proximamente extends StatefulWidget {
  const Proximamente({super.key});

  @override
  State<Proximamente> createState() => _ProximamenteState();
}

class _ProximamenteState extends State<Proximamente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade400,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade400,
        title: const Text(""),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icons-coding.png', width: 40),
        ),
        const Text(
          "Proximamente..",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        )
      ])),
    );
  }
}
