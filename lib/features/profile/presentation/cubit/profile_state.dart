part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final int bottomNavIndex;
  
  ProfileLoaded({this.bottomNavIndex = 2});
}
