import 'package:flutter/material.dart';
import 'rating_widget.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String image;
  final double rating;
  final int messagesCount;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.messagesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE4ECFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    color: Color(0xFF3B72FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RatingWidget(icon: Icons.star, text: rating.toString()),
                    const SizedBox(width: 8),
                    RatingWidget(icon: Icons.chat_bubble_outline, text: messagesCount.toString()),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              _buildSmallIconButton(Icons.question_mark),
              const SizedBox(height: 8),
              _buildSmallIconButton(Icons.favorite_border),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: const Color(0xFF3B72FF),
        size: 16,
      ),
    );
  }
}
