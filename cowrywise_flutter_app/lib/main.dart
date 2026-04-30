import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const SkillBoardApp());
}

class SkillBoardApp extends StatelessWidget {
  const SkillBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillBoard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const OnboardingScreen(),
      routes: {
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
