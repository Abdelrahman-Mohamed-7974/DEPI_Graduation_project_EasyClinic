import 'package:flutter/material.dart';

class NotificationHeader extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onNewsTap;

  const NotificationHeader({
    super.key,
    required this.onBackTap,
    required this.onNewsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBackTap,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF3B72FF),
            size: 24,
          ),
        ),
        const Text(
          'Notification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onNewsTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF3B72FF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'News',
                  style: TextStyle(
                    color: Color(0xFF3B72FF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B72FF),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
