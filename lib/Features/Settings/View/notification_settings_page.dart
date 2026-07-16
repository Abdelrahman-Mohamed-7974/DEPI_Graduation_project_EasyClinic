import 'package:easy_clinic/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool generalNotification = true;
  bool sound = true;
  bool soundCall = true;
  bool vibrate = false;
  bool specialOffers = false;
  bool payments = true;
  bool promoAndDiscount = false;
  bool cashback = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Notification Setting',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            _buildSwitchItem(
              'General Notification',
              generalNotification,
              (val) => setState(() => generalNotification = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Sound',
              sound,
              (val) => setState(() => sound = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Sound Call',
              soundCall,
              (val) => setState(() => soundCall = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Vibrate',
              vibrate,
              (val) => setState(() => vibrate = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Special Offers',
              specialOffers,
              (val) => setState(() => specialOffers = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Payments',
              payments,
              (val) => setState(() => payments = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Promo And Discount',
              promoAndDiscount,
              (val) => setState(() => promoAndDiscount = val),
            ),
            const SizedBox(height: 28),
            _buildSwitchItem(
              'Cashback',
              cashback,
              (val) => setState(() => cashback = val),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Transform.scale(
          scale: 1.3,
          child: CustomSvgSwitch(value: value, onChanged: onChanged),
        ),
      ],
    );
  }
}

class CustomSvgSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSvgSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: SizedBox(
        width: 52,
        height: 26,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            SvgPicture.asset(
              'assets/icons/Rectangle 37.svg',
              width: 52,
              height: 26,
              colorFilter: value
                  ? null
                  : const ColorFilter.mode(Color(0xFFC4D3FF), BlendMode.srcIn),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 29 : 3,
              child: SvgPicture.asset(
                'assets/icons/Ellipse 31.svg',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
