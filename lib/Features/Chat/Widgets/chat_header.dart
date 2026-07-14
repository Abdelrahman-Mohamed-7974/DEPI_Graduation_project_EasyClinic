import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  final String doctorName;
  final VoidCallback onBackTap;
  final VoidCallback onCallTap;
  final VoidCallback onVideoTap;

  const ChatHeader({
    super.key,
    required this.doctorName,
    required this.onBackTap,
    required this.onCallTap,
    required this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF3B72FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: onBackTap,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                doctorName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildHeaderIcon(Icons.call_outlined, onCallTap),
            const SizedBox(width: 12),
            _buildHeaderIcon(Icons.videocam_outlined, onVideoTap),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
