import 'package:flutter/material.dart';

class NotificationViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Scheduled Appointment',
      'description':
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '2 M',
      'icon': Icons.calendar_today,
      'section': 'Today',
      'isHighlighted': false,
    },
    {
      'title': 'Scheduled Change',
      'description':
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '2 H',
      'icon': Icons.calendar_today,
      'section': 'Today',
      'isHighlighted': true,
    },
    {
      'title': 'Medical Notes',
      'description':
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '3 H',
      'icon': Icons.calendar_today,
      'section': 'Today',
      'isHighlighted': false,
    },
    {
      'title': 'Scheduled Appointment',
      'description':
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '1 D',
      'icon': Icons.calendar_today,
      'section': 'Yesterday',
      'isHighlighted': false,
    },
    {
      'title': 'Medical History Update',
      'description':
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '5 D',
      'icon': Icons.calendar_today,
      'section': '15 April',
      'isHighlighted': false,
    },
  ];

  List<Map<String, dynamic>> get notifications => _notifications;

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification['isHighlighted'] = false;
    }
    notifyListeners();
  }
}
