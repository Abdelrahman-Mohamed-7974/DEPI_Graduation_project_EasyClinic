import 'package:flutter/material.dart';
import '../ViewModel/chat_view_model.dart';

/// A received voice-note bubble: sender avatar, play button, progress bar and
/// duration. Static UI only — no real audio playback.
class VoiceMessageBubble extends StatelessWidget {
  final MessageModel message;

  const VoiceMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEFF9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: message.avatar != null
                      ? NetworkImage(message.avatar!)
                      : null,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B72FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                _buildWaveTrack(),
                const SizedBox(width: 10),
                Text(
                  message.duration ?? '',
                  style: const TextStyle(
                    color: Color(0xFF3B72FF),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.time,
            style: const TextStyle(
              color: Color(0xFF9AA5C4),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildWaveTrack() {
    return SizedBox(
      width: 110,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFFBBC6E8),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.55,
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFF3B72FF),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.1, 0),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xFF3B72FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
