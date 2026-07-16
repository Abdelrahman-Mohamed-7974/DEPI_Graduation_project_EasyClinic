import 'dart:io';

import 'package:easy_clinic/Features/Auth/View/login_screen.dart';
import 'package:easy_clinic/Features/Common/View/empty_page.dart';
import 'package:easy_clinic/Features/HelpCenter/View/help_center_page.dart';
import 'package:easy_clinic/Features/Payment/View/payment_method_screen.dart';
import 'package:easy_clinic/Features/PrivacyPolicy/View/privacy_policy_page.dart';
import 'package:easy_clinic/Features/Profile/Cubit/profile_cubit.dart';
import 'package:easy_clinic/Features/Profile/Cubit/user_cubit.dart';
import 'package:easy_clinic/Features/Profile/View/edit_profile_page.dart';
import 'package:easy_clinic/Features/Profile/Widgets/profile_menu_item.dart';
import 'package:easy_clinic/Features/Settings/View/settings_page.dart';
import 'package:easy_clinic/Features/Auth/Cubit/auth_cubit.dart';
import 'package:easy_clinic/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  final bool showBackButton;

  const ProfilePage({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          automaticallyImplyLeading: showBackButton,
          leading: showBackButton
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary,
                  ),
                  onPressed: () => Navigator.maybePop(context),
                )
              : null,
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 25,
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
                  Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: userState.profileImagePath.isNotEmpty
                                ? FileImage(File(userState.profileImagePath))
                                : const NetworkImage(
                                    'https://randomuser.me/api/portraits/men/1.jpg',
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfilePage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/pen.svg',
                                width: 30,
                                height: 30,
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
                  const SizedBox(height: 14),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: 'assets/icons/Vector 158 (Stroke) (1).svg',
                    title: 'Favorite',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const EmptyPage(title: 'Favorite'),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: 'assets/icons/Vector13.svg',
                    title: 'Payment Method',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentMethodScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: 'assets/icons/Vector (1).svg',
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: 'assets/icons/Vector 12.svg',
                    title: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: 'assets/icons/Group 25.svg',
                    title: 'Help',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpCenterPage(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: 'assets/icons/log  out.svg',
                    title: 'Logout',
                    onTap: () async {
                      await context.read<AuthCubit>().logout();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
