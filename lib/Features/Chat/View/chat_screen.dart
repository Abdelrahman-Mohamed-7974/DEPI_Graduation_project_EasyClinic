import 'package:flutter/material.dart';
import '../ViewModel/chat_view_model.dart';
import '../Widgets/chat_header.dart';
import '../Widgets/chat_bubble.dart';
import '../Widgets/voice_message_bubble.dart';
import '../Widgets/chat_input_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatViewModel _viewModel = ChatViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ChatHeader(
            doctorName: 'Dr. Olivia Turner',
            onBackTap: () => Navigator.maybePop(context),
            onCallTap: () {},
            onVideoTap: () {},
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: _viewModel.messages.length,
              itemBuilder: (context, index) {
                final message = _viewModel.messages[index];
                if (message['isVoice'] == true) {
                  return VoiceMessageBubble(
                    duration: message['voiceDuration'],
                    time: message['time'],
                  );
                }
                return ChatBubble(
                  text: message['text'],
                  time: message['time'],
                  isSent: message['isSent'],
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24.0, bottom: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dr. Olivia is typing...',
                style: TextStyle(
                  color: Color(0xFF3B72FF),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          ChatInputBar(
            controller: _viewModel.messageController,
            onSend: () => _viewModel.sendMessage(),
            onAttachment: () {},
            onMic: () {},
          ),
        ],
      ),
    );
  }
}
