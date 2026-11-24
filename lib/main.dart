import 'package:flutter/material.dart';
import 'splash_widget.dart';

void main() => runApp(const SisterSkansikaApp());

class SisterSkansikaApp extends StatelessWidget {
  const SisterSkansikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sister Skansika',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F2854)),
      ),
      home: const SplashWidget(),
    );
  }
}