import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() => runApp(const QATestTaskApp());

class QATestTaskApp extends StatelessWidget {
  const QATestTaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QA Automation Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const LoginScreen(),
    );
  }
}
