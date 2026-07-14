import 'package:supabase_flutter/supabase_flutter.dart';

/// Data access for in-app notifications backed by Supabase.
///
/// Notifications are created server-side by a Postgres trigger whenever a
/// chat message is inserted (see supabase/migrations/*_notifications.sql),
/// and stream to the app over Realtime.
class NotificationService {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<List<Map<String, dynamic>>> notificationStream(String recipientRole) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('recipient_role', recipientRole)
        .order('created_at', ascending: false);
  }

  Future<void> markAllRead(String recipientRole) async {
    await _client
        .from('notifications')
        .update({'is_read': true})
        .eq('recipient_role', recipientRole)
        .eq('is_read', false);
  }
}
