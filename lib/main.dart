import 'package:flutter/material.dart';

void main() {
  runApp(const DevOpsApp());
}

class DevOpsApp extends StatelessWidget {
  const DevOpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DevOps Practical',
      home: Scaffold(
        body: Center(
          child: Text('Hello, DevOps World! V1'),
        ),
      ),
    );
  }
}
