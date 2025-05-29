import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionhr/view/auth/onboardingAuth.dart';
import 'package:visionhr/view/onbording_screen/onbording_screen.dart';
import '../navigationbar/navigationbar.dart';

class KeepLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is logged in
          return Onboarding_Screen();
        } else {
          // User is not logged in
          return OnboardingAuth();
        }
      },
    );
  }
}
