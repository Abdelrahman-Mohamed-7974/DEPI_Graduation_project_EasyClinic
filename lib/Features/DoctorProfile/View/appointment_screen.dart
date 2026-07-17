import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String image;
  final double rating;
  final int messagesCount;

  const AppointmentScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.messagesCount,
  });

  final Color primaryBlue = const Color(0xFF2260FF);
  final Color lightBlue = const Color(0xFFCAD6FF);
  final Color bgColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildTopAppBar(context),
                const SizedBox(height: 24),
                _buildDoctorCard(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 20),
                _buildDateTimeSection(),
                const SizedBox(height: 20),
                _buildDivider(),
                const SizedBox(height: 24),
                _buildPatientDetails(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),
                _buildProblemSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: primaryBlue, size: 22),
        ),
        Expanded(
          child: Text(
            'Your Appointment',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryBlue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 22), // Balance the back button for centering
      ],
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Image
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 40, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Pill
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        specialty,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Badges row
                Row(
                  children: [
                    _buildInfoChip('assets/star.svg', rating.toString()),
                    const SizedBox(width: 8),
                    _buildInfoChip('assets/Group 14.svg', messagesCount.toString()), // Message icon for 60
                    const Spacer(),
                    _buildCircleIcon('assets/mark.svg'),
                    const SizedBox(width: 6),
                    _buildCircleIcon('assets/feavorit.svg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String iconAsset, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 12,
            height: 12,
            colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: primaryBlue,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(String assetName) {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        assetName,
        width: 12,
        height: 12,
        colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Month 24, Year',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                'WED, 10:00 AM',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primaryBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primaryBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatientDetails() {
    return Column(
      children: [
        _buildDetailRow('Booking For', 'Another Person'),
        const SizedBox(height: 12),
        _buildDetailRow('Full Name', 'Jane Doe'),
        const SizedBox(height: 12),
        _buildDetailRow('Age', '30'),
        const SizedBox(height: 12),
        _buildDetailRow('Gender', 'Female'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProblemSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Problem',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: primaryBlue,
    );
  }
}
