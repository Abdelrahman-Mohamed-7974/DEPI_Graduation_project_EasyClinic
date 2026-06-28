import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Make the UI fully responsive using MediaQuery
    final size = MediaQuery.sizeOf(context);
    const primaryColor = Color(0xFF2260FF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo image from assets
              Image.asset(
                'assets/Welcome_Screen_Logo.png',
                width: size.width * 0.35, // Keep aspect ratio, responsive width
                fit: BoxFit.contain,
              ),

              SizedBox(height: size.height * 0.03),

              // "Skin" text
              const Text(
                'Skin',
                style: TextStyle(
                  fontSize: 48,
                  color: primaryColor,
                  fontWeight: FontWeight.w300,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),

              // "Firts" text
              const Text(
                'Firts',
                style: TextStyle(
                  fontSize: 48,
                  color: primaryColor,
                  fontWeight: FontWeight.w300,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: size.height * 0.02),

              // "Dermatology Center" text
              const Text(
                'Dermatology Center',
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: size.height * 0.06),

              // Description text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, \nsed do eiusmod tempor incididunt ut labore et dolore \nmagna aliqua.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: size.height * 0.08),

              // Log In Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to Login Screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Sign Up Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to Sign Up Screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDCE5FF),
                      foregroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
