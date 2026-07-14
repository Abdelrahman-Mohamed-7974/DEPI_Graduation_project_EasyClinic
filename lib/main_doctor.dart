import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:easy_clinic/Features/Message/View/chat_screen.dart';
import 'package:easy_clinic/core/chat_config.dart';
import 'package:easy_clinic/core/supabase_config.dart';

/// Standalone entry point for the Doctor app.
///
/// This app is JUST the chat interface — no splash, auth, home, or bottom nav.
/// Run it with:  flutter run --flavor doctor -t lib/main_doctor.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    // Local Supabase's anon JWT is sent as the apikey header; publishableKey
    // is the current (non-deprecated) param for that value.
    publishableKey: SupabaseConfig.anonKey,
  );
  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Clinic — Doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0066FF),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0066FF),
          secondary: Color(0xFF003366),
          surface: Color(0xFFF5F7FA),
        ),
        fontFamily: 'Inter',
      ),
      home: const ChatScreen(
        myRole: ChatConfig.doctorRole,
        peerName: 'Patient',
      ),
    );
  }
}
