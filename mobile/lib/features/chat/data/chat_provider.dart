import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_message_model.dart';
import 'package:uuid/uuid.dart';
import '../../notifications/data/notification_provider.dart';

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier(this.ref) : super([]);

  final Ref ref;
  final _uuid = const Uuid();

  void sendMessage({
    required String from,
    required String to,
    required String text,
  }) {
    final msg = ChatMessage(
      id: _uuid.v4(),
      senderId: from,
      receiverId: to,
      text: text,
      time: DateTime.now(),
    );

    state = [...state, msg];

    /// trigger notification
    ref
        .read(notificationProvider.notifier)
        .addNotification("New message", "Message from $from");
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(ref),
);
