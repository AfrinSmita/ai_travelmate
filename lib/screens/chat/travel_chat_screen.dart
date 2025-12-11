import 'package:flutter/material.dart';
import '../../models/chat_message.dart';
import '../../services/ai_service.dart';

class TravelChatScreen extends StatefulWidget {
  const TravelChatScreen({super.key});

  @override
  State<TravelChatScreen> createState() => _TravelChatScreenState();
}

class _TravelChatScreenState extends State<TravelChatScreen> {
  final controller = TextEditingController();
  final List<ChatMessage> messages = [
    ChatMessage("Hi! Ask me anything about travel", false)
  ];

  bool typing = false;

  Future<void> sendMsg() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text, true));
      typing = true;
    });
    controller.clear();

    final reply = await AIService.chatReply(text);

    setState(() {
      messages.add(ChatMessage(reply, false));
      typing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Travel Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (typing ? 1 : 0),
              itemBuilder: (context, index) {
                if (typing && index == messages.length) {
                  return const Text("AI is typing...");
                }

                final msg = messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                          color: msg.isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Type a message...",
                    border: OutlineInputBorder()),
              )),
              IconButton(onPressed: sendMsg, icon: const Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
