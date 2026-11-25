import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/text_analyzer/presentation/pages/text_analyzer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Text Analyzer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const TextAnalyzerPage(),
    );
  }
}
