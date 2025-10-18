import 'package:flutter/material.dart';
import 'package:skypulse/screens/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkyPulse',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEBEBEB)),
      home: const LoadingScreen(),
    );
  }
}
