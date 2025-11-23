import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'order_model.dart';

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super([]);

  void createOrder(Order order) {
    state = [...state, order];
  }

  void updateStatus(String orderId, OrderStatus status) {
    state = [
      for (final o in state)
        if (o.id == orderId) o.copyWith(status: status) else o,
    ];
  }

  List<Order> ordersForSupplier(String supplierId) =>
      state.where((o) => o.supplierId == supplierId).toList();

  List<Order> ordersForConsumer(String consumerId) =>
      state.where((o) => o.consumerId == consumerId).toList();
}

final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>(
  (ref) => OrderNotifier(),
);
