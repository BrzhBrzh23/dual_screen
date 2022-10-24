
import 'package:dual_screen/login_page.dart';
import 'package:dual_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  final bool showLogin;
  const SplashScreen({super.key, required this.showLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        animationDuration: const Duration(milliseconds: 1500),
        nextScreen: showLogin ? LoginPage() : const OnBoardingScreen(),
        splash: Image.asset(
          'assets/images/logo2.gif',
        ),
      ),
    );
  }
}
