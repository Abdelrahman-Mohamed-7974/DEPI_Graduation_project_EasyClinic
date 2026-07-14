/// Shared chat identifiers used by both the patient and doctor apps.
///
/// Until real auth + patient/doctor selection is wired up, both apps talk in a
/// single fixed conversation so you can test the round-trip end to end.
class ChatConfig {
  ChatConfig._();

  /// Both apps read/write this same conversation row set.
  static const String demoConversationId = 'demo-room';

  static const String patientRole = 'patient';
  static const String doctorRole = 'doctor';
}
