import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../orders/data/order_provider.dart';
import '../../auth/data/auth_providers.dart';
import '../../orders/data/order_model.dart';

class ConsumerOrdersScreen extends ConsumerWidget {
  const ConsumerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allOrders = ref.watch(orderProvider);
    final auth = ref.read(authRepositoryProvider);

    return FutureBuilder(
      future: auth.getUserId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        final myId = snapshot.data!;
        final orders = allOrders.where((o) => o.consumerId == myId).toList();
        if (orders.isEmpty) return const Center(child: Text("No orders"));
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (_, i) {
            final o = orders[i];
            return ListTile(
              title: Text("Order ${o.id}"),
              subtitle: Text("Status: ${o.status.name}"),
            );
          },
        );
      },
    );
  }
}
