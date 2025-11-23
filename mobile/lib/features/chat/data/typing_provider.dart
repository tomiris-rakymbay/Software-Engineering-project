import 'package:flutter_riverpod/flutter_riverpod.dart';

final typingProvider = StateNotifierProvider<TypingNotifier, Map<String, bool>>(
  (ref) => TypingNotifier(),
);

class TypingNotifier extends StateNotifier<Map<String, bool>> {
  TypingNotifier() : super({});

  void setTyping(String chatId, bool isTyping) {
    state = {...state, chatId: isTyping};
  }
}
