import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'booking_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String image;
  final double rating;
  final int messagesCount;

  const DoctorProfileScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.messagesCount,
  });

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final Color primaryBlue = const Color(0xFF2260FF);
  final Color lightBlue = const Color(0xFFCAD6FF);
  final Color bgColor = const Color(0xFFFFFFFF);

  int selectedDay = 24;
  final int currentDay = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section with 30px horizontal padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildTopAppBar(),
                    const SizedBox(height: 24),
                    _buildProfileCard(),
                    const SizedBox(height: 24),
                    _buildProfileDescription(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              // Calendar section without 30px horizontal padding
              _buildCalendarSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: primaryBlue, size: 22),
        ),
        const SizedBox(width: 16),
        // Schedule Button
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingScreen(
                doctorName: widget.doctorName,
                specialty: widget.specialty,
                image: widget.image,
                rating: widget.rating,
                messagesCount: widget.messagesCount,
                initialSelectedDate: selectedDay,
              )),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/schedule.svg', width: 14, height: 14, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                const SizedBox(width: 6),
                const Text('Schedule', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildActionIcon('assets/call.svg', isBlue: true),
        const SizedBox(width: 6),
        _buildActionIcon('assets/camera.svg', isBlue: true),
        const SizedBox(width: 6),
        _buildActionIcon('assets/Group 14.svg', isBlue: true),
        const Spacer(),
        _buildActionIcon('assets/mark.svg', isBlue: false),
        const SizedBox(width: 8),
        _buildActionIcon('assets/feavorit.svg', isBlue: false),
      ],
    );
  }

  Widget _buildActionIcon(String assetName, {required bool isBlue}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: isBlue ? primaryBlue : lightBlue,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          assetName,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(isBlue ? Colors.white : primaryBlue, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Image
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Fallback
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 60, color: Colors.grey[600]);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/doctericon.svg', width: 20, height: 20, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                '20 years\nexperience',
                                style: TextStyle(color: Colors.white, fontSize: 13, height: 1.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 13),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Focus: The impact of hormonal imbalances on skin conditions, specializing in acne, hirsutism, and other skin disorders.',
                            style: TextStyle(color: Colors.white, fontSize: 11, height: 1.25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(
                  widget.doctorName,
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.specialty,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip('assets/star.svg', widget.rating.toString()),
              const SizedBox(width: 10),
              _buildInfoChip('assets/Group 14.svg', widget.messagesCount.toString()), // Message icon as placeholder for comments
              const SizedBox(width: 10),
              Expanded(child: _buildInfoChip('assets/clock.svg', 'Mon - Sat / 9 AM - 4 PM')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String iconAsset, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 14,
            height: 14,
            colorFilter: ColorFilter.mode(primaryBlue, BlendMode.srcIn),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: primaryBlue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: TextStyle(
            color: primaryBlue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      width: double.infinity,
      color: lightBlue,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios_new, color: primaryBlue, size: 16),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 16),
              Text(
                'MONTH',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios, color: primaryBlue, size: 16),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Days row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'
            ].map((day) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                day,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            )).toList(),
          ),
          const SizedBox(height: 16),
          // Calendar Grid
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.1,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: 31,
              itemBuilder: (context, index) {
                int day = index + 1;
                bool isSelected = day == selectedDay;
                bool isPast = day < currentDay;

                return GestureDetector(
                  onTap: () {
                    if (!isPast) {
                      setState(() {
                        selectedDay = day;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? primaryBlue : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$day',
                      style: TextStyle(
                        color: isSelected ? Colors.white : (isPast ? lightBlue : Colors.black87),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
