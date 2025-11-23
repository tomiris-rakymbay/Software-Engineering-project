import 'package:flutter/material.dart';
import '../data/supplier_model.dart';

class SupplierCard extends StatelessWidget {
  final Supplier supplier;
  final VoidCallback onTap;

  const SupplierCard({super.key, required this.supplier, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Supplier logo (placeholder)
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: supplier.logoUrl != null
                    ? NetworkImage(supplier.logoUrl!)
                    : null,
                child: supplier.logoUrl == null
                    ? const Icon(Icons.store, size: 32, color: Colors.grey)
                    : null,
              ),

              const SizedBox(width: 16),

              // Name + description + status badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      supplier.description ?? "No description",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 10),

                    _statusBadge(supplier.status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(SupplierLinkStatus status) {
    late Color color;
    late String text;

    switch (status) {
      case SupplierLinkStatus.linked:
        color = Colors.green;
        text = "Linked";
        break;
      case SupplierLinkStatus.pending:
        color = Colors.orange;
        text = "Pending";
        break;
      case SupplierLinkStatus.notLinked:
      default:
        color = Colors.blueGrey;
        text = "Not Linked";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
