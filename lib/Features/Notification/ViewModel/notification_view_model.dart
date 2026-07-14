import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Services/notification_service.dart';

/// The visual/icon type of a notification, used to pick its leading icon.
enum NotificationType { appointment, change, notes, history, message }

class NotificationItemModel {
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final bool isHighlighted;
  final String section;

  const NotificationItemModel({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.section,
    this.isHighlighted = false,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.appointment:
      case NotificationType.change:
        return Icons.calendar_today;
      case NotificationType.notes:
        return Icons.description_outlined;
      case NotificationType.history:
      case NotificationType.message:
        return Icons.forum_outlined;
    }
  }

  factory NotificationItemModel.fromRow(Map<String, dynamic> row) {
    final created =
        DateTime.tryParse(row['created_at'] as String? ?? '')?.toLocal() ??
            DateTime.now();
    return NotificationItemModel(
      title: row['title'] as String? ?? '',
      description: row['body'] as String? ?? '',
      time: _relativeLabel(created),
      type: _typeFrom(row['type'] as String?),
      section: _sectionFor(created),
      isHighlighted: !(row['is_read'] as bool? ?? true),
    );
  }

  static NotificationType _typeFrom(String? raw) {
    switch (raw) {
      case 'appointment':
        return NotificationType.appointment;
      case 'change':
        return NotificationType.change;
      case 'notes':
        return NotificationType.notes;
      case 'history':
        return NotificationType.history;
      default:
        return NotificationType.message;
    }
  }

  /// Compact age label matching the design: "2 M", "3 H", "1 D".
  static String _relativeLabel(DateTime created) {
    final diff = DateTime.now().difference(created);
    if (diff.inMinutes < 1) return 'Now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} M';
    if (diff.inHours < 24) return '${diff.inHours} H';
    return '${diff.inDays} D';
  }

  static String _sectionFor(DateTime created) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(created.year, created.month, created.day);
    if (day == today) return 'Today';
    if (day == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return DateFormat('d MMMM').format(created);
  }
}

class NotificationViewModel extends ChangeNotifier {
  /// Which app's notifications to show: 'patient' or 'doctor'.
  final String recipientRole;

  final NotificationService _service;

  List<NotificationItemModel> _notifications = const [];
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;

  NotificationViewModel({
    required this.recipientRole,
    NotificationService? service,
  }) : _service = service ?? NotificationService() {
    _subscription = _service.notificationStream(recipientRole).listen((rows) {
      _notifications = rows.map(NotificationItemModel.fromRow).toList();
      notifyListeners();
    });
  }

  List<NotificationItemModel> get notifications => _notifications;

  /// Ordered list of section labels as they should appear, de-duplicated.
  List<String> get sections {
    final seen = <String>[];
    for (final item in _notifications) {
      if (!seen.contains(item.section)) seen.add(item.section);
    }
    return seen;
  }

  List<NotificationItemModel> itemsForSection(String section) =>
      _notifications.where((n) => n.section == section).toList();

  Future<void> markAllRead() => _service.markAllRead(recipientRole);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
