import 'package:easy_clinic/Features/Auth/View/splash_screen.dart';
import 'package:easy_clinic/Features/Profile/Cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_clinic/core/database/database_helper.dart';
import 'package:easy_clinic/Features/Auth/Cubit/auth_cubit.dart';
import 'package:easy_clinic/Features/Home/Cubit/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database; // Ensure database is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => AuthCubit()..checkSession()),
        BlocProvider(create: (_) => HomeCubit()..loadHomeData()),
      ],
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
        home: const SplashScreen(),
      ),
    );
  }
}
