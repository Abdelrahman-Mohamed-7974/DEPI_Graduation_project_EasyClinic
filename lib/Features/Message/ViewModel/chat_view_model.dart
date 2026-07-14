import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Services/chat_service.dart';

enum MessageType { text, voice }

class MessageModel {
  final String? text;
  final String time;
  final bool isSent;
  final MessageType type;

  /// For voice messages: total duration label (e.g. "02:50") and sender avatar.
  final String? duration;
  final String? avatar;

  const MessageModel({
    required this.time,
    required this.isSent,
    this.text,
    this.type = MessageType.text,
    this.duration,
    this.avatar,
  });

  /// Builds a bubble from a Supabase `messages` row. Whether the bubble is
  /// "sent" (right-aligned) depends on which app is viewing it: a row is
  /// outgoing when its sender_role matches this app's role.
  factory MessageModel.fromRow(Map<String, dynamic> row, String myRole) {
    final createdRaw = row['created_at'] as String?;
    final created = createdRaw != null
        ? DateTime.tryParse(createdRaw)?.toLocal()
        : null;
    return MessageModel(
      text: row['content'] as String?,
      time: created != null ? DateFormat('HH:mm').format(created) : '',
      isSent: row['sender_role'] == myRole,
    );
  }
}

class ChatViewModel extends ChangeNotifier {
  /// This app's identity in the conversation: 'patient' or 'doctor'.
  final String myRole;

  /// The conversation both apps share.
  final String conversationId;

  /// Name shown in the header (the other party).
  final String peerName;

  final ChatService _service;

  List<MessageModel> _messages = const [];
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;

  ChatViewModel({
    required this.myRole,
    required this.conversationId,
    this.peerName = 'Chat',
    ChatService? service,
  }) : _service = service ?? ChatService() {
    _subscription = _service.messageStream(conversationId).listen(
      (rows) {
        _messages = rows
            .map((row) => MessageModel.fromRow(row, myRole))
            .toList();
        notifyListeners();
      },
    );
  }

  List<MessageModel> get messages => _messages;

  /// Kept for the view; live typing indicators are a later enhancement.
  bool get isTyping => false;

  Future<void> sendMessage(String text) async {
    final content = text.trim();
    if (content.isEmpty) return;
    await _service.sendMessage(
      conversationId: conversationId,
      senderRole: myRole,
      content: content,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
