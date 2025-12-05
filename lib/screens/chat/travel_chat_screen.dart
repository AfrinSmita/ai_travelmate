import 'package:flutter/material.dart';
import '../../models/chat_message.dart';

class TravelChatScreen extends StatefulWidget {
  const TravelChatScreen({super.key});

  @override
  State<TravelChatScreen> createState() => _TravelChatScreenState();
}

class _TravelChatScreenState extends State<TravelChatScreen> {
  final controller = TextEditingController();
  final messages = <ChatMessage>[
    ChatMessage("Hi! Ask me anything about travel!", false)
  ];
  bool typing = false;

  void sendMsg() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text, true));
      typing = true;
      controller.clear();
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      messages.add(ChatMessage("AI reply (demo): real answers will come after connecting GPT API.", false));
      typing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Travel Guide")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[messages.length - 1 - i];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (typing) const Text("AI is typing..."),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ask something...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMsg,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
