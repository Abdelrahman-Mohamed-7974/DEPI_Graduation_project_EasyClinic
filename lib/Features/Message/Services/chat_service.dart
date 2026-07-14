import 'package:supabase_flutter/supabase_flutter.dart';

/// Data access for chat messages backed by Supabase (Postgres + Realtime).
///
/// `messageStream` returns a live-updating list: every insert/update to the
/// `messages` table for the given conversation is pushed over the Realtime
/// websocket, so both the patient and doctor apps stay in sync automatically.
class ChatService {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<List<Map<String, dynamic>>> messageStream(String conversationId) {
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderRole,
    required String content,
  }) async {
    await _client.from('messages').insert({
      'conversation_id': conversationId,
      'sender_role': senderRole,
      'content': content,
    });
  }
}
