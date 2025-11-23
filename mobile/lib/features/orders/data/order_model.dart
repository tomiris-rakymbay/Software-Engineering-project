enum OrderStatus { pending, accepted, rejected, shipped, delivered }

class OrderItem {
  final String productId;
  final int qty;

  OrderItem({required this.productId, required this.qty});
}

class Order {
  final String id;
  final String supplierId;
  final String consumerId;
  final List<OrderItem> items;
  final OrderStatus status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.supplierId,
    required this.consumerId,
    required this.items,
    this.status = OrderStatus.pending,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Order copyWith({OrderStatus? status}) {
    return Order(
      id: id,
      supplierId: supplierId,
      consumerId: consumerId,
      items: items,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }
}
