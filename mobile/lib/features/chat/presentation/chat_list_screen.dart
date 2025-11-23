import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/chat_list_provider.dart';
import 'chat_screen.dart';

class ChatListScreen extends ConsumerWidget {
  final String myId;
  final String myName;

  const ChatListScreen({super.key, required this.myId, required this.myName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatListProvider(myId));

    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final c = chats[index];

          // fake unread count / online flag generated from chatId for demo
          final unread = c.chatId.hashCode % 3; // 0..2 messages unread (demo)
          final online = c.otherId.hashCode % 2 == 0;

          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  child: Text(c.otherName.isNotEmpty ? c.otherName[0] : "?"),
                ),
                if (online)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(c.otherName),
            subtitle: Text(
              c.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: unread > 0
                ? CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Text(
                      unread.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    chatId: c.chatId,
                    myId: myId,
                    myName: myName,
                    otherId: c.otherId,
                    otherName: c.otherName,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
