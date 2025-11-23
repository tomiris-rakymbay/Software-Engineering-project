import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatSummary {
  final String chatId;
  final String otherId;
  final String otherName;
  final String lastMessage;

  ChatSummary({
    required this.chatId,
    required this.otherId,
    required this.otherName,
    required this.lastMessage,
  });
}

final chatListProvider = Provider.family<List<ChatSummary>, String>((
  ref,
  selfId,
) {
  // Temporary fake data — replace with real linking logic later
  return [
    ChatSummary(
      chatId: "chat_01",
      otherId: "supplier_1",
      otherName: "Supplier PRO",
      lastMessage: "Hello Consumer!",
    ),
    ChatSummary(
      chatId: "chat_02",
      otherId: "supplier_2",
      otherName: "Supplier XYZ",
      lastMessage: "Your order shipped",
    ),
  ];
});
