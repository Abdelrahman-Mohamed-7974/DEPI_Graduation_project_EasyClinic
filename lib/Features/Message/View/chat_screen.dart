import 'package:flutter/material.dart';
import '../../../core/chat_config.dart';
import '../ViewModel/chat_view_model.dart';
import '../Widgets/chat_header.dart';
import '../Widgets/chat_input_bar.dart';
import '../Widgets/message_bubble.dart';
import '../Widgets/voice_message_bubble.dart';

class ChatScreen extends StatefulWidget {
  /// This app's role in the conversation: 'patient' or 'doctor'.
  final String myRole;

  /// Name of the other party shown in the header.
  final String peerName;

  /// Shared conversation both apps read/write.
  final String conversationId;

  const ChatScreen({
    super.key,
    this.myRole = ChatConfig.patientRole,
    this.peerName = 'Dr. Olivia Turner',
    this.conversationId = ChatConfig.demoConversationId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatViewModel _viewModel;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = ChatViewModel(
      myRole: widget.myRole,
      conversationId: widget.conversationId,
      peerName: widget.peerName,
    );
    _viewModel.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _inputController.text;
    _inputController.clear();
    FocusScope.of(context).unfocus();
    _viewModel.sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ChatHeader(
            doctorName: _viewModel.peerName,
            onCall: () {},
            onVideoCall: () {},
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              children: [
                ..._viewModel.messages.map((message) {
                  if (message.type == MessageType.voice) {
                    return VoiceMessageBubble(message: message);
                  }
                  return MessageBubble(message: message);
                }),
                if (_viewModel.isTyping) _buildTypingIndicator(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            child: ChatInputBar(
              controller: _inputController,
              onSend: _handleSend,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Text(
        '${_viewModel.peerName.split(' ').take(2).join(' ')} is typing...',
        style: const TextStyle(
          color: Color(0xFF3B72FF),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
