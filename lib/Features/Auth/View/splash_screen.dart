import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/welcome');
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF2260FF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo image from assets
              Image.asset(
                'assets/Splash_Screen_Logo.png',
                width: size.width * 0.3, // Responsive width
                fit: BoxFit.contain,
              ),

              // Responsive vertical spacing
              SizedBox(height: size.height * 0.03),

              // "Skin" text
              const Text(
                'Skin',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  height: 1.1, // Keeps the two large text lines close
                ),
                textAlign: TextAlign.center,
              ),

              // "Firts" text
              const Text(
                'Firts',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),

              // Responsive vertical spacing
              SizedBox(height: size.height * 0.02),

              // "Dermatology Center" text
              const Text(
                'Dermatology Center',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
