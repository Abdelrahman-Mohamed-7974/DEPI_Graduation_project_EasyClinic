import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/database/database_helper.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> doctors;
  final List<Map<String, dynamic>> appointments;

  HomeLoaded({required this.doctors, required this.appointments});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('loggedInUserId') ?? 1;

      final db = await DatabaseHelper.instance.database;
      final doctors = await db.rawQuery(
        '''
        SELECT d.*, 
               CASE WHEN f.id IS NOT NULL THEN 1 ELSE 0 END as is_favorite_user
        FROM doctors d
        LEFT JOIN favorites f ON d.id = f.doctor_id AND f.user_id = ?
      ''',
        [userId],
      );
      final appointments = await db.query('appointments');

      emit(HomeLoaded(doctors: doctors, appointments: appointments));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> searchDoctors(String query) async {
    emit(HomeLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('loggedInUserId') ?? 1;

      final db = await DatabaseHelper.instance.database;
      final doctors = await db.rawQuery(
        '''
        SELECT d.*, 
               CASE WHEN f.id IS NOT NULL THEN 1 ELSE 0 END as is_favorite_user
        FROM doctors d
        LEFT JOIN favorites f ON d.id = f.doctor_id AND f.user_id = ?
        WHERE d.name LIKE ? OR d.specialization LIKE ?
      ''',
        [userId, '%$query%', '%$query%'],
      );
      final appointments = await db.query('appointments');

      emit(HomeLoaded(doctors: doctors, appointments: appointments));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> toggleFavorite(int doctorId, bool isCurrentlyFavorite) async {
    if (state is! HomeLoaded) return;
    final currentState = state as HomeLoaded;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('loggedInUserId') ?? 1;
      final db = await DatabaseHelper.instance.database;

      if (isCurrentlyFavorite) {
        await db.delete(
          'favorites',
          where: 'user_id = ? AND doctor_id = ?',
          whereArgs: [userId, doctorId],
        );
      } else {
        await db.insert('favorites', {
          'user_id': userId,
          'doctor_id': doctorId,
        });
      }

      // Update state immediately without hitting DB again
      final newDoctors = currentState.doctors.map((doc) {
        if (doc['id'] == doctorId) {
          return {...doc, 'is_favorite_user': isCurrentlyFavorite ? 0 : 1};
        }
        return doc;
      }).toList();

      emit(
        HomeLoaded(
          doctors: newDoctors,
          appointments: currentState.appointments,
        ),
      );
    } catch (e) {
      // Revert or show error could be done here
      emit(HomeError(e.toString()));
      loadHomeData();
    }
  }
}
