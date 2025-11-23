import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notification_provider.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              ref.read(notificationProvider.notifier).markAllAsRead();
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (_, i) {
                final n = notifications[i];
                return ListTile(
                  leading: Icon(
                    n.read ? Icons.notifications : Icons.notifications_active,
                    color: n.read ? Colors.grey : Colors.blue,
                  ),
                  title: Text(n.title),
                  subtitle: Text(n.message),
                  trailing: Text(
                    "${n.time.hour}:${n.time.minute.toString().padLeft(2, '0')}",
                  ),
                  onTap: () {
                    ref.read(notificationProvider.notifier).markAsRead(n.id);
                  },
                );
              },
            ),
    );
  }
}
