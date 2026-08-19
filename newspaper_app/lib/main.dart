import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NewspaperApp());
}

class NewspaperApp extends StatelessWidget {
  const NewspaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Daily Wire',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
