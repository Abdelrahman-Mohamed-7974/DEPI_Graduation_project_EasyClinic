import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'appointment_screen.dart';

class BookingScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String image;
  final double rating;
  final int messagesCount;
  final int? initialSelectedDate;

  const BookingScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.messagesCount,
    this.initialSelectedDate,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Color primaryBlue = const Color(0xFF2260FF);
  final Color lightBlue = const Color(0xFFCAD6FF);
  final Color bgColor = const Color(0xFFFFFFFF);
  final Color inputBgColor = const Color(0xFFE8EFFF); // Lighter blue for inputs
  final Color disabledBgColor = const Color(0xFFD9D9D9);
  
  // Selection States
  late int selectedDate;
  String selectedTime = '10:00 AM';
  bool isForAnotherPerson = true;
  String selectedGender = 'Female';

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialSelectedDate ?? 24;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildTopAppBar(),
              ),
              const SizedBox(height: 20),
              
              // Horizontal Calendar Section
              _buildHorizontalCalendar(),
              
              // Main content with padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Available Time'),
                    const SizedBox(height: 16),
                    _buildTimeGrid(),
                    
                    const SizedBox(height: 24),
                    Divider(color: primaryBlue.withOpacity(0.5), thickness: 1),
                    const SizedBox(height: 24),
                    
                    _buildSectionTitle('Patient Details'),
                    const SizedBox(height: 12),
                    _buildPatientTypeToggle(),
                    
                    const SizedBox(height: 20),
                    _buildLabel('Full Name'),
                    _buildTextField('Jane Doe'),
                    
                    const SizedBox(height: 16),
                    _buildLabel('Age'),
                    _buildTextField('30'),
                    
                    const SizedBox(height: 16),
                    _buildLabel('Gender'),
                    _buildGenderToggle(),
                    
                    const SizedBox(height: 24),
                    Divider(color: primaryBlue.withOpacity(0.5), thickness: 1),
                    const SizedBox(height: 24),
                    
                    _buildLabel('Describe your problem'),
                    _buildProblemTextArea(),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: primaryBlue, size: 22),
        ),
        const SizedBox(width: 16),
        // Doctor Name Pill
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(widget.doctorName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ),
        const SizedBox(width: 12),
        _buildActionIcon('assets/call.svg', isBlue: true),
        const SizedBox(width: 6),
        _buildActionIcon('assets/camera.svg', isBlue: true),
        const SizedBox(width: 6),
        _buildActionIcon('assets/Group 14.svg', isBlue: true),
        const SizedBox(width: 24),
        _buildActionIcon('assets/mark.svg', isBlue: false),
        const SizedBox(width: 8),
        _buildActionIcon('assets/feavorit.svg', isBlue: false),
        ],
      ),
    );
  }

  Widget _buildActionIcon(String assetName, {required bool isBlue}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isBlue ? primaryBlue : lightBlue,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          assetName,
          width: 14,
          height: 14,
          colorFilter: ColorFilter.mode(isBlue ? Colors.white : primaryBlue, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildHorizontalCalendar() {
    return Container(
      width: double.infinity,
      color: lightBlue,
      padding: const EdgeInsets.only(top: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text('Month', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down, color: primaryBlue, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_back_ios_new, color: primaryBlue.withOpacity(0.5), size: 18),
                _buildDateItem(selectedDate >= 3 ? selectedDate - 2 : 22, 'MON'),
                _buildDateItem(selectedDate >= 2 ? selectedDate - 1 : 23, 'TUE'),
                _buildDateItem(selectedDate, 'WED'),
                _buildDateItem(selectedDate <= 30 ? selectedDate + 1 : 25, 'THU', isBlack: true),
                _buildDateItem(selectedDate <= 29 ? selectedDate + 2 : 26, 'FRI'),
                _buildDateItem(selectedDate <= 28 ? selectedDate + 3 : 27, 'SAT'),
                Icon(Icons.arrow_forward_ios, color: primaryBlue.withOpacity(0.5), size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateItem(int day, String dayName, {bool isBlack = false}) {
    bool isSelected = day == selectedDate;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = day;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Text(
              '$day',
              style: TextStyle(
                color: isSelected ? Colors.white : (isBlack ? Colors.black : lightBlue),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dayName,
              style: TextStyle(
                color: isSelected ? Colors.white : (isBlack ? Colors.black54 : lightBlue),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: primaryBlue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTimeGrid() {
    List<Map<String, dynamic>> times = [
      {'time': '9:00 AM', 'status': 'available'},
      {'time': '9:30 AM', 'status': 'available'},
      {'time': '10:00 AM', 'status': 'selected'},
      {'time': '19:30 AM', 'status': 'available'}, // typo in design "19:30 AM"
      {'time': '11:00 AM', 'status': 'available'},
      {'time': '11:30 AM', 'status': 'disabled'}, // greyed out
      {'time': '12:00 M', 'status': 'available'},
      {'time': '12:30 M', 'status': 'available'},
      {'time': '1:00 PM', 'status': 'disabled'},
      {'time': '1:30 PM', 'status': 'disabled'},
      {'time': '2:00 PM', 'status': 'available'},
      {'time': '2:30 PM', 'status': 'disabled'},
      {'time': '3:00 PM', 'status': 'disabled'},
      {'time': '3:30 PM', 'status': 'available'},
      {'time': '4:00 PM', 'status': 'available'},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: times.map((t) {
        bool isSelected = t['status'] == 'selected' || t['time'] == selectedTime;
        bool isDisabled = t['status'] == 'disabled';
        
        Color bgColor = isSelected ? primaryBlue : (isDisabled ? disabledBgColor : inputBgColor);
        Color textColor = isSelected ? Colors.white : (isDisabled ? Colors.black54 : primaryBlue.withOpacity(0.6));

        return GestureDetector(
          onTap: () {
            if (!isDisabled) {
              setState(() {
                selectedTime = t['time'];
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              t['time'],
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPatientTypeToggle() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildToggleBtn('Yourself', !isForAnotherPerson, () {
          setState(() => isForAnotherPerson = false);
        }),
        const SizedBox(width: 12),
        _buildToggleBtn('Another Person', isForAnotherPerson, () {
          setState(() => isForAnotherPerson = true);
        }),
        ],
      ),
    );
  }

  Widget _buildGenderToggle() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildToggleBtn('Male', selectedGender == 'Male', () {
          setState(() => selectedGender = 'Male');
        }),
        const SizedBox(width: 12),
        _buildToggleBtn('Female', selectedGender == 'Female', () {
          setState(() => selectedGender = 'Female');
        }),
        const SizedBox(width: 12),
        _buildToggleBtn('Other', selectedGender == 'Other', () {
          setState(() => selectedGender = 'Other');
        }),
        ],
      ),
    );
  }

  Widget _buildToggleBtn(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: lightBlue),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : lightBlue,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: primaryBlue.withOpacity(0.6), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: TextStyle(color: primaryBlue, fontSize: 14),
      ),
    );
  }

  Widget _buildProblemTextArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightBlue),
      ),
      child: TextField(
        maxLines: 5,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointmentScreen(
              doctorName: widget.doctorName,
              specialty: widget.specialty,
              image: widget.image,
              rating: widget.rating,
              messagesCount: widget.messagesCount,
            )),
          );
        },
        decoration: InputDecoration(
          hintText: 'Enter Your Problem Here...',
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
