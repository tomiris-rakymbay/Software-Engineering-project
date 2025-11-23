import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notification_model.dart';
import 'package:uuid/uuid.dart';

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier() : super([]);

  final _uuid = const Uuid();

  void addNotification(String title, String message) {
    final notif = AppNotification(
      id: _uuid.v4(),
      title: title,
      message: message,
      time: DateTime.now(),
    );
    state = [notif, ...state];
  }

  void markAsRead(String id) {
    state = [
      for (final n in state)
        if (n.id == id) n.copyWith(read: true) else n,
    ];
  }

  void markAllAsRead() {
    state = [for (final n in state) n.copyWith(read: true)];
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<AppNotification>>(
      (ref) => NotificationNotifier(),
    );
