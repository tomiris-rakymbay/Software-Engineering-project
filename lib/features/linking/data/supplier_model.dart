enum SupplierLinkStatus { notLinked, pending, linked }

class Supplier {
  final String id;
  final String name;
  final String? description;
  final SupplierLinkStatus status;
  final String? logoUrl;

  Supplier({
    required this.id,
    required this.name,
    this.description,
    this.status = SupplierLinkStatus.notLinked,
    this.logoUrl,
  });

  Supplier copyWith({
    String? id,
    String? name,
    String? description,
    SupplierLinkStatus? status,
    String? logoUrl,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }
}
