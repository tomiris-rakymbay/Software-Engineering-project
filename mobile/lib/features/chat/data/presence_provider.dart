import 'package:flutter_riverpod/flutter_riverpod.dart';

final presenceProvider =
    StateNotifierProvider<PresenceNotifier, Map<String, bool>>(
      (ref) => PresenceNotifier(),
    );

class PresenceNotifier extends StateNotifier<Map<String, bool>> {
  PresenceNotifier() : super({});

  void setOnline(String userId, bool isOnline) {
    state = {...state, userId: isOnline};
  }
}
