import 'package:flutter/material.dart';

import 'app.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Md. Shoroardi Sumon - Portfolio',
      theme: AppThemes.darkTheme(),
      home: const PortfolioHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}