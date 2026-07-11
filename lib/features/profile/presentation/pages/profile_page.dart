import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import '../../../../core/constants/colors.dart';
import '../../../empty/empty_page.dart';
import '../../../privacy_policy/presentation/pages/privacy_policy_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/user_cubit.dart';
import 'edit_profile_page.dart';
import '../widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            onPressed: () {},
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Picture
                  Stack(
                    children: [
                      Container(
                        width: 106,
                        height: 106,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: userState.profileImagePath.isNotEmpty
                                ? FileImage(File(userState.profileImagePath)) as ImageProvider
                                : const NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/pen.svg',
                                width: 18,
                                height: 18,
                                fit: BoxFit.scaleDown,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14, width: 118),
                  Text(
                    userState.fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 30),
              
              ProfileMenuItem(
                iconPath: 'assets/icons/Vector.svg',
                title: 'Profile',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                },
              ),
              ProfileMenuItem(
                iconPath: 'assets/icons/Vector 158 (Stroke) (1).svg',
                title: 'Favorite',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmptyPage(title: 'Favorite')));
                },
              ),
              ProfileMenuItem(
                iconPath: 'assets/icons/Vector (1).svg',
                title: 'Payment Method',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmptyPage(title: 'Payment Method')));
                },
              ),
              ProfileMenuItem(
                iconPath: 'assets/icons/Vector13.svg',
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
                },
              ),
              ProfileMenuItem(
                iconPath: 'assets/icons/Vector 12.svg',
                title: 'Settings',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                },
              ),
              ProfileMenuItem(
                iconPath: 'assets/icons/Group 25.svg',
                title: 'Help',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmptyPage(title: 'Help')));
                },
              ),
              ProfileMenuItem(
                iconPath: 'assets/icons/log  out.svg',
                title: 'Logout',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmptyPage(title: 'Logout')));
                },
              ),
            ],
          ),
        );
      },
    ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        int currentIndex = 2; // Default to profile index
        if (state is ProfileLoaded) {
          currentIndex = state.bottomNavIndex;
        }

        return Container(
          margin: const EdgeInsets.only(top: 40, left: 31, right: 31, bottom: 30),
          height: 65,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, 'assets/icons/Vector (9).svg', 0, currentIndex),
              _buildNavItem(context, 'assets/icons/Vector (8).svg', 1, currentIndex),
              _buildNavItem(context, 'assets/icons/Vector (7).svg', 2, currentIndex),
              _buildNavItem(context, 'assets/icons/Vector (6).svg', 3, currentIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, String iconPath, int index, int currentIndex) {
    return GestureDetector(
      onTap: () {
        context.read<ProfileCubit>().changeBottomNavIndex(index);
      },
      child: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          currentIndex == index ? Colors.white : Colors.white.withValues(alpha: 0.5),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
