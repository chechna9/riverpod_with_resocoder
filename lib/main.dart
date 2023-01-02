import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Counter',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(),
    );
  }
}
