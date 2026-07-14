import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '09:00',
      'isSent': true,
      'isVoice': false,
    },
    {
      'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '09:30',
      'isSent': false,
      'isVoice': false,
    },
    {
      'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'time': '09:43',
      'isSent': true,
      'isVoice': false,
    },
    {
      'text': '',
      'time': '09:50',
      'isSent': false,
      'isVoice': true,
      'voiceDuration': '02:50',
    },
    {
      'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '09:55',
      'isSent': true,
      'isVoice': false,
    },
  ];

  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> get messages => _messages;

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      final now = DateTime.now();
      final timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      _messages.add({
        'text': messageController.text.trim(),
        'time': timeString,
        'isSent': true,
        'isVoice': false,
      });
      messageController.clear();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
