import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result.isNotEmpty) {
        final user = result.first;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('loggedInUserId', user['id'] as int);
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signup(Map<String, dynamic> user) async {
    emit(AuthLoading());
    try {
      final db = await DatabaseHelper.instance.database;

      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [user['email']],
      );

      if (existingUser.isNotEmpty) {
        emit(AuthFailure('Email already exists'));
        return;
      }

      final id = await db.insert('users', user);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('loggedInUserId', id);

      user['id'] = id;
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUserId');
    emit(AuthInitial());
  }

  Future<void> checkSession() async {
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
        emit(AuthSuccess(result.first));
        return;
      }
    }
    emit(AuthInitial());
  }
}
