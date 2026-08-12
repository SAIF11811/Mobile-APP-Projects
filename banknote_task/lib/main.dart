import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const BanknoteTaskApp());
}

class BanknoteTaskApp extends StatelessWidget {
  const BanknoteTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banknote · Call Log Summary',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}
