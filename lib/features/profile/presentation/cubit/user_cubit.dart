import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── State ───────────────────────────────────────────────────────────────────
class UserState {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String dateOfBirth;
  final String profileImagePath;

  UserState({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.dateOfBirth,
    required this.profileImagePath,
  });

  UserState copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? dateOfBirth,
    String? profileImagePath,
  }) {
    return UserState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}

// ─── Cubit ────────────────────────────────────────────────────────────────────
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(
    fullName: 'John Doe',
    phoneNumber: '+123 567 89000',
    email: 'johndoe@example.com',
    dateOfBirth: 'DD / MM /YYYY',
    profileImagePath: '',
  )) {
    _loadFromPrefs();
  }

  // Load persisted data from SharedPreferences
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final fullName = prefs.getString('fullName') ?? state.fullName;
    final phone = prefs.getString('phoneNumber') ?? state.phoneNumber;
    final email = prefs.getString('email') ?? state.email;
    final dob = prefs.getString('dateOfBirth') ?? state.dateOfBirth;
    final imgPath = prefs.getString('profileImagePath') ?? state.profileImagePath;
    emit(UserState(
      fullName: fullName,
      phoneNumber: phone,
      email: email,
      dateOfBirth: dob,
      profileImagePath: imgPath,
    ));
  }

  // Update profile and persist values
  void updateProfile({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? dateOfBirth,
    String? profileImagePath,
  }) async {
    emit(state.copyWith(
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      dateOfBirth: dateOfBirth,
      profileImagePath: profileImagePath,
    ));
    final prefs = await SharedPreferences.getInstance();
    if (fullName != null) await prefs.setString('fullName', fullName);
    if (phoneNumber != null) await prefs.setString('phoneNumber', phoneNumber);
    if (email != null) await prefs.setString('email', email);
    if (dateOfBirth != null) await prefs.setString('dateOfBirth', dateOfBirth);
    if (profileImagePath != null) await prefs.setString('profileImagePath', profileImagePath);
  }
}
