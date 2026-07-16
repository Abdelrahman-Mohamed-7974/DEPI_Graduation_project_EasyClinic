import 'package:easy_clinic/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  bool _isFaq = false;
  int _selectedTopicIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 24,
              top: 10,
            ),
            child: Column(
              children: [
                const Text(
                  'How Can We Help You?',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Vectorsearch.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: AppColors.lightBlue,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    title: 'FAQ',
                    isActive: _isFaq,
                    onTap: () => setState(() => _isFaq = true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTabButton(
                    title: 'Contact Us',
                    isActive: !_isFaq,
                    onTap: () => setState(() => _isFaq = false),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _isFaq ? _buildFaqContent() : _buildContactUsContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : const Color(0xFFDEE5FF),
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFaqContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              _buildFilterChip('Popular Topic', 0),
              const SizedBox(width: 10),
              Expanded(child: _buildFilterChip('General', 1)),
              const SizedBox(width: 10),
              Expanded(child: _buildFilterChip('Services', 2)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              _buildFaqItem(
                question: 'How to book an appointment?',
                answer:
                    'You can easily book an appointment by navigating to the home screen, searching for your desired clinic or doctor, and selecting an available time slot that fits your schedule.',
              ),
              const SizedBox(height: 16),
              _buildFaqItem(
                question: 'How to cancel or reschedule?',
                answer:
                    'To cancel or reschedule, go to your upcoming appointments, select the appointment you wish to change, and choose either the cancel or reschedule option.',
              ),
              const SizedBox(height: 16),
              _buildFaqItem(
                question: 'Is my medical data secure?',
                answer:
                    'Yes, we take data privacy very seriously. All your medical records and personal information are encrypted and stored securely following the highest industry standards.',
              ),
              const SizedBox(height: 16),
              _buildFaqItem(
                question: 'How to contact my doctor?',
                answer:
                    'You can use the chat feature in the app to directly communicate with your doctor regarding any follow-ups or urgent questions you might have.',
              ),
              const SizedBox(height: 16),
              _buildFaqItem(
                question: 'What are the clinic working hours?',
                answer:
                    'Working hours vary depending on the specific clinic and doctor. You can find the exact working hours on the doctor\'s profile page before booking.',
              ),
              const SizedBox(height: 16),
              _buildFaqItem(
                question: 'How to pay for consultation?',
                answer:
                    'We support multiple payment methods including credit/debit cards, digital wallets, and cash on arrival. You can select your preferred method during checkout.',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String title, int index) {
    final isActive = _selectedTopicIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTopicIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : const Color(0xFFDEE5FF),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.primary,
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactUsContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        _buildContactItem(
          iconPath: 'assets/icons/vector_custmor.svg',
          title: 'Customer Service',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          iconPath: 'assets/icons/Vectorweb.svg',
          title: 'Website',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          iconPath: 'assets/icons/Vectorwhatsapp.svg',
          title: 'Whatsapp',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          iconPath: 'assets/icons/insta.svg',
          title: 'Facebook',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          iconPath: 'assets/icons/facebook.svg',
          title: 'Instagram',
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildContactItem({required String iconPath, required String title}) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFFDEE5FF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.primary,
          size: 28,
        ),
      ],
    );
  }
}
