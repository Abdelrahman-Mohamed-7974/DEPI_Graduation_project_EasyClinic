import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/database/database_helper.dart';

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

class UserCubit extends Cubit<UserState> {
  UserCubit()
    : super(
        UserState(
          fullName: 'John Doe',
          phoneNumber: '+123 567 89000',
          email: 'johndoe@example.com',
          dateOfBirth: 'DD / MM /YYYY',
          profileImagePath: '',
        ),
      ) {
    _loadFromDb();
  }

  Future<void> _loadFromDb() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('loggedInUserId');
    if (userId != null) {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (result.isNotEmpty) {
        final user = result.first;
        emit(
          UserState(
            fullName: user['name'] as String? ?? state.fullName,
            phoneNumber: user['phone'] as String? ?? state.phoneNumber,
            email: user['email'] as String? ?? state.email,
            dateOfBirth: user['birth_date'] as String? ?? state.dateOfBirth,
            profileImagePath:
                user['profile_image'] as String? ?? state.profileImagePath,
          ),
        );
      }
    }
  }

  void updateProfile({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? dateOfBirth,
    String? profileImagePath,
  }) async {
    emit(
      state.copyWith(
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        dateOfBirth: dateOfBirth,
        profileImagePath: profileImagePath,
      ),
    );

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('loggedInUserId');
    if (userId != null) {
      final db = await DatabaseHelper.instance.database;
      final updateData = <String, dynamic>{};
      if (fullName != null) {
        updateData['name'] = fullName;
      }
      if (phoneNumber != null) {
        updateData['phone'] = phoneNumber;
      }
      if (email != null) {
        updateData['email'] = email;
      }
      if (dateOfBirth != null) {
        updateData['birth_date'] = dateOfBirth;
      }
      if (profileImagePath != null) {
        updateData['profile_image'] = profileImagePath;
      }

      if (updateData.isNotEmpty) {
        await db.update(
          'users',
          updateData,
          where: 'id = ?',
          whereArgs: [userId],
        );
      }
    }
  }
}
