import 'package:flutter/material.dart';
import 'package:country_information_app/splashScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab_Asm_1',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const splashScreen(),
    );
  }
}
