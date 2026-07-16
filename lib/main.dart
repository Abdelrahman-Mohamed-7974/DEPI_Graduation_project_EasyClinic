import 'package:easy_clinic/Features/Auth/View/splash_screen.dart';
import 'package:easy_clinic/Features/Profile/Cubit/user_cubit.dart';
import 'package:easy_clinic/Features/Root/root_screen.dart';
import 'package:easy_clinic/core/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// DEV ONLY: set to true to skip splash/welcome/login and go straight to the app.
/// Must be false for release.
const bool kBypassLogin = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    // Local Supabase's anon JWT is sent as the apikey header; publishableKey
    // is the current (non-deprecated) param for that value.
    publishableKey: SupabaseConfig.anonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: MaterialApp(
        title: 'Easy Clinic',
        theme: ThemeData(
          primaryColor: const Color(0xFF0066FF),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0066FF),
            secondary: Color(0xFF003366),
            surface: Color(0xFFF5F7FA),
          ),
          fontFamily: 'Inter',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0066FF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: kBypassLogin ? const RootScreen() : const SplashScreen(),
      ),
    );
  }
}
