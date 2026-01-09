import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static const String routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    final String name = (ModalRoute.of(context)?.settings.arguments as String?) ?? 'Mr. Shandy';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(name, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.black54),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              children: const [
                _Bubble(text: 'Do you know my address sir?', isMe: true),
                _Bubble(text: "Don’t worry, I’ve been there last week. Please wait", isMe: false, tone: _BubbleTone.reply),
                _Bubble(text: 'OK', isMe: true),
              ],
            ),
          ),
          _InputBar(onSend: (text) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Send: $text')));
          }),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, required this.isMe, this.tone = _BubbleTone.normal});
  final String text;
  final bool isMe;
  final _BubbleTone tone;
  @override
  Widget build(BuildContext context) {
    final Color bg = isMe ? primaryGreen : const Color(0xFFF3D8AE);
    final BorderRadius radius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isMe ? 20 : 4),
      bottomRight: Radius.circular(isMe ? 4 : 20),
    );
    final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 18);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: padding,
        decoration: BoxDecoration(color: bg, borderRadius: radius),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 20, height: 1.4),
        ),
      ),
    );
  }
}

enum _BubbleTone { normal, reply }

class _InputBar extends StatefulWidget {
  const _InputBar({required this.onSend});
  final ValueChanged<String> onSend;
  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFE9EBEC)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Type message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              elevation: 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  final text = controller.text.trim();
                  if (text.isEmpty) return;
                  widget.onSend(text);
                  controller.clear();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.send_rounded, color: primaryGreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


