import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../orders/data/order_provider.dart';
import '../../orders/data/order_model.dart';
import '../../auth/data/auth_providers.dart';

class SupplierOrdersScreen extends ConsumerWidget {
  const SupplierOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allOrders = ref.watch(orderProvider);
    final auth = ref.read(authRepositoryProvider);
    return FutureBuilder(
      future: auth.getUserId(), // supply the supplier id for sales account
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        final supplierId = snapshot.data!;
        final orders = allOrders
            .where((o) => o.supplierId == supplierId)
            .toList();
        if (orders.isEmpty) return const Center(child: Text("No orders"));
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (_, i) {
            final o = orders[i];
            return Card(
              child: ListTile(
                title: Text("Order ${o.id}"),
                subtitle: Text(
                  "Items: ${o.items.length} • Status: ${o.status.name}",
                ),
                trailing: o.status == OrderStatus.pending
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => ref
                                .read(orderProvider.notifier)
                                .updateStatus(o.id, OrderStatus.accepted),
                            child: const Text("Accept"),
                          ),
                          TextButton(
                            onPressed: () => ref
                                .read(orderProvider.notifier)
                                .updateStatus(o.id, OrderStatus.rejected),
                            child: const Text("Reject"),
                          ),
                        ],
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}
