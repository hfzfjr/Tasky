import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF4F46E5);

    return MaterialApp(
      title: 'Tasky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
