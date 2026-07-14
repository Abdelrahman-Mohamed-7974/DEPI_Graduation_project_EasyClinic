import 'package:flutter/material.dart';
import '../../../core/chat_config.dart';
import '../ViewModel/notification_view_model.dart';
import '../Widgets/notification_item.dart';
import '../Widgets/section_pill.dart';

class NotificationScreen extends StatefulWidget {
  /// Which app's notifications to show: 'patient' or 'doctor'.
  final String recipientRole;

  const NotificationScreen({
    super.key,
    this.recipientRole = ChatConfig.patientRole,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = NotificationViewModel(recipientRole: widget.recipientRole);
    _viewModel.addListener(() {
      if (mounted) setState(() {});
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildTopRow(),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: _buildSections(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(24),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF3B72FF),
            size: 22,
          ),
        ),
        const Text(
          'Notification',
          style: TextStyle(
            color: Color(0xFF3B72FF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE4ECFF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'News',
                style: TextStyle(
                  color: Color(0xFF3B72FF),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 6),
              CircleAvatar(radius: 4, backgroundColor: Color(0xFF3B72FF)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SectionPill(label: 'Today'),
        InkWell(
          onTap: _viewModel.markAllRead,
          child: const Text(
            'Mark all',
            style: TextStyle(
              color: Color(0xFF3B72FF),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSections() {
    final widgets = <Widget>[];
    final sections = _viewModel.sections;
    for (var i = 0; i < sections.length; i++) {
      final section = sections[i];
      // "Today" is rendered in the fixed top row, so skip its header here.
      if (section != 'Today') {
        widgets
          ..add(const SizedBox(height: 8))
          ..add(SectionPill(label: section))
          ..add(const SizedBox(height: 4));
      }
      for (final item in _viewModel.itemsForSection(section)) {
        widgets.add(NotificationItem(notification: item));
      }
    }
    return widgets;
  }
}
