import 'package:flutter/material.dart';
import 'package:information_app/screens/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

