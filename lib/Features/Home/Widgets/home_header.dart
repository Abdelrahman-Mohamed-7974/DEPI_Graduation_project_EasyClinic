import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String userImage;
  final VoidCallback onNotificationTap;
  final VoidCallback onSettingsTap;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.userImage,
    required this.onNotificationTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 24, backgroundImage: NetworkImage(userImage)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi, WelcomeBack',
                  style: TextStyle(color: Color(0xFF3B72FF), fontSize: 12),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildIconButton(Icons.notifications_none, onNotificationTap),
            const SizedBox(width: 8),
            _buildIconButton(Icons.settings_outlined, onSettingsTap),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFE4ECFF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF3B72FF), size: 20),
      ),
    );
  }
}
