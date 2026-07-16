import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoaded());

  void changeBottomNavIndex(int index) {
    emit(ProfileLoaded(bottomNavIndex: index));
  }
}
