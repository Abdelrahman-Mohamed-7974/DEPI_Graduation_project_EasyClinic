import 'package:flutter/material.dart';
import 'package:easy_clinic/Features/Auth/View/splash_screen.dart';
import 'package:easy_clinic/Features/Auth/View/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Clinic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2260FF)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        } else if (settings.name == '/welcome') {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                  ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          );
        }
        return null;
      },
    );
  }
}
