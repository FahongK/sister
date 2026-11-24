import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0F2854),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_rounded, size: 80, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Sister Skansika',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'SMK Negeri 1 Bukateja',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            SizedBox(height: 28),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}