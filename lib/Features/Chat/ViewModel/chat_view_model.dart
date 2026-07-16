import 'package:flutter/material.dart';
import '../../../../core/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> _messages = [];
  final TextEditingController messageController = TextEditingController();
  final int conversationId = 1; // Default for demo

  List<Map<String, dynamic>> get messages => _messages;

  ChatViewModel() {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'messages',
      where: 'conversation_id = ?',
      whereArgs: [conversationId],
      orderBy: 'id ASC',
    );

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('loggedInUserId') ?? 1;

    _messages = result.map((m) {
      return {
        'text': m['text'],
        'time': m['time'],
        'isSent': m['sender_id'] == userId,
        'isVoice': false, // mock
      };
    }).toList();
    notifyListeners();
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      final now = DateTime.now();
      final timeString =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      final text = messageController.text.trim();

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('loggedInUserId') ?? 1;

      final db = await DatabaseHelper.instance.database;
      await db.insert('messages', {
        'conversation_id': conversationId,
        'sender_id': userId,
        'text': text,
        'time': timeString,
      });

      _messages.add({
        'text': text,
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
