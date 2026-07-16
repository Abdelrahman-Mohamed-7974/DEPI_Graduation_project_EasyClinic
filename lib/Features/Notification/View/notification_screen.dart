import 'package:flutter/material.dart';
import '../ViewModel/notification_view_model.dart';
import '../Widgets/notification_header.dart';
import '../Widgets/section_label.dart';
import '../Widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationViewModel _viewModel = NotificationViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationHeader(
                  onBackTap: () => Navigator.maybePop(context),
                  onNewsTap: () {},
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SectionLabel(text: 'Today'),
                    GestureDetector(
                      onTap: () => _viewModel.markAllAsRead(),
                      child: const Text(
                        'Mark all',
                        style: TextStyle(
                          color: Color(0xFF3B72FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ..._buildNotificationSection('Today'),
                const SizedBox(height: 16),
                const SectionLabel(text: 'Yesterday'),
                const SizedBox(height: 16),
                ..._buildNotificationSection('Yesterday'),
                const SizedBox(height: 16),
                const SectionLabel(text: '15 April'),
                const SizedBox(height: 16),
                ..._buildNotificationSection('15 April'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNotificationSection(String section) {
    return _viewModel.notifications
        .where((n) => n['section'] == section)
        .map(
          (n) => NotificationItem(
            title: n['title'],
            description: n['description'],
            time: n['time'],
            icon: n['icon'],
            isHighlighted: n['isHighlighted'],
          ),
        )
        .toList();
  }
}
