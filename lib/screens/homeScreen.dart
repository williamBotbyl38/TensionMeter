import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SM5 Tension Meter Application"),
      ),
      body: const Center(
        child: Text('SM5 tension meter app'),
      ),
    );
  }
}
