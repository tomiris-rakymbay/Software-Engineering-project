import 'package:flutter_riverpod/flutter_riverpod.dart';

final unreadProvider = StateNotifierProvider<UnreadNotifier, Map<String, int>>(
  (ref) => UnreadNotifier(),
);

class UnreadNotifier extends StateNotifier<Map<String, int>> {
  UnreadNotifier() : super({});

  void increment(String chatId) {
    final current = state[chatId] ?? 0;
    state = {...state, chatId: current + 1};
  }

  void reset(String chatId) {
    state = {...state, chatId: 0};
  }
}
