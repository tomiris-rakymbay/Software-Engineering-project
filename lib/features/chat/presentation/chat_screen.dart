import 'dart:async';

import 'package:flutter/material.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime time;
  final bool read;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.time,
    this.read = false,
  });
}

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String myId;
  final String myName;
  final String otherId;
  final String otherName;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.myId,
    required this.myName,
    required this.otherId,
    required this.otherName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  bool _otherTyping = false;
  bool _otherOnline = true;

  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    // Populate some demo messages
    _messages.addAll([
      Message(
        id: "m1",
        senderId: widget.otherId,
        text: "Hi! Welcome to Supplier chat.",
        time: DateTime.now().subtract(const Duration(minutes: 10)),
        read: true,
      ),
      Message(
        id: "m2",
        senderId: widget.myId,
        text: "Thanks — can you share catalog?",
        time: DateTime.now().subtract(const Duration(minutes: 8)),
        read: true,
      ),
    ]);

    // Simulate other typing occasionally (demo)
    Future.delayed(const Duration(seconds: 5), () {
      setState(() => _otherTyping = true);
      _typingTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          _otherTyping = false;
          _messages.add(
            Message(
              id: "m_external_${DateTime.now().millisecondsSinceEpoch}",
              senderId: widget.otherId,
              text: "Sure — check product #123.",
              time: DateTime.now(),
              read: false,
            ),
          );
          _scrollToBottom();
        });
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom({int delayMs = 50}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    final m = Message(
      id: "m_${DateTime.now().millisecondsSinceEpoch}",
      senderId: widget.myId,
      text: text,
      time: DateTime.now(),
      read: false,
    );

    setState(() {
      _messages.add(m);
      _ctrl.clear();
    });

    _scrollToBottom();

    // DEMO: simulate a short reply from other side
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _otherTyping = true;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _otherTyping = false;
          _messages.add(
            Message(
              id: "m_auto_${DateTime.now().millisecondsSinceEpoch}",
              senderId: widget.otherId,
              text: "Thanks — got your message: \"${m.text}\"",
              time: DateTime.now(),
            ),
          );
          _scrollToBottom();
        });
      });
    });
  }

  Widget _buildBubble(Message m) {
    final mine = m.senderId == widget.myId;
    final align = mine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = mine ? Colors.blue.shade600 : Colors.grey.shade200;
    final textColor = mine ? Colors.white : Colors.black87;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: Radius.circular(mine ? 12 : 0),
      bottomRight: Radius.circular(mine ? 0 : 12),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(color: color, borderRadius: radius),
            child: Text(m.text, style: TextStyle(color: textColor)),
          ),
          const SizedBox(height: 4),
          Text(
            _formatTime(m.time),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime t) {
    final now = DateTime.now();
    if (now.difference(t).inDays >= 1) return "${t.day}/${t.month}/${t.year}";
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return "$hh:$mm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(
                widget.otherName.isNotEmpty ? widget.otherName[0] : '?',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.otherName, style: const TextStyle(fontSize: 16)),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _otherOnline ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _otherOnline ? "Online" : "Offline",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                itemCount: _messages.length + (_otherTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_otherTyping && index == _messages.length) {
                    // typing indicator row
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final m = _messages[index];
                  return _buildBubble(m);
                },
              ),
            ),

            // input bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
