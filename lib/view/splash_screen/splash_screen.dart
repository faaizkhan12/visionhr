import 'package:flutter/material.dart';

import '../auth/onboardingAuth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingAuth()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/splash_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Image.asset(
                'assets/splash_logo.png',
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
