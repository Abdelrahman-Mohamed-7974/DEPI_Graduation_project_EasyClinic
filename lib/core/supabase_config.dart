/// Connection details for the local Supabase stack (`supabase start`).
///
/// The Android emulator cannot reach the host's `127.0.0.1` — it maps the host
/// loopback to the special address `10.0.2.2`, so that's what the app uses.
///
/// The anon key below is the standard local-dev key printed by `supabase
/// status`. It is safe to commit for LOCAL development only. When you move to a
/// hosted project, replace both values (ideally via --dart-define at build time).
class SupabaseConfig {
  SupabaseConfig._();

  /// Host loopback as seen from the Android emulator.
  static const String url = 'http://10.0.2.2:54321';

  /// Local anon key from `supabase status` (local dev only). It's a JWT with
  /// role=anon, which Realtime needs to authorize the websocket.
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
}
