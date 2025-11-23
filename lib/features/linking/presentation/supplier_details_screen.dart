// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../linking/data/supplier_model.dart';
// import '../../consumer/data/linked_suppliers_provider.dart';
// import '../../sales/data/link_requests_provider.dart';
// import '../../sales/data/link_requets_model.dart';

// class SupplierDetailsScreen extends ConsumerWidget {
//   final Supplier supplier;

//   const SupplierDetailsScreen({super.key, required this.supplier});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final linked = ref.watch(linkedSuppliersProvider);
//     final isLinked = linked.any((s) => s.id == supplier.id);

//     return Scaffold(
//       appBar: AppBar(title: Text(supplier.name)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               supplier.description ?? "No description available",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 30),

//             /// STATUS DISPLAY
//             Row(
//               children: [
//                 const Text("Status:", style: TextStyle(fontSize: 16)),
//                 const SizedBox(width: 8),
//                 _statusBadge(supplier.status),
//               ],
//             ),

//             const SizedBox(height: 30),

//             /// ACTION BUTTON
//             ElevatedButton(
//               onPressed: () {
//                 final notifier = ref.read(linkedSuppliersProvider.notifier);

//                 if (supplier.status == SupplierLinkStatus.notLinked) {
//                   // 1) SEND REQUEST TO SALES
//                   ref
//                       .read(linkRequestsProvider.notifier)
//                       .addRequest(
//                         consumerName: "Consumer User", // TODO dynamic
//                         consumerEmail: "consumer@test.com",
//                         supplier: supplier,
//                       );

//                   notifier.sendRequest(supplier);
//                 } else if (supplier.status == SupplierLinkStatus.linked) {
//                   notifier.unlinkSupplier(supplier.id);
//                 } else if (supplier.status == SupplierLinkStatus.pending) {
//                   // future feature: cancel request
//                 }
//               },
//               child: Text(
//                 supplier.status == SupplierLinkStatus.notLinked
//                     ? "Send Link Request"
//                     : supplier.status == SupplierLinkStatus.linked
//                     ? "Unlink Supplier"
//                     : "Request Pending…",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// STATUS BADGE WIDGET
//   Widget _statusBadge(SupplierLinkStatus status) {
//     switch (status) {
//       case SupplierLinkStatus.notLinked:
//         return const Chip(
//           label: Text("Not Linked"),
//           backgroundColor: Colors.grey,
//         );
//       case SupplierLinkStatus.pending:
//         return const Chip(
//           label: Text("Pending"),
//           backgroundColor: Colors.orange,
//         );
//       case SupplierLinkStatus.linked:
//         return const Chip(label: Text("Linked"), backgroundColor: Colors.green);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../linking/data/supplier_model.dart';
import '../../consumer/data/linked_suppliers_provider.dart';
import '../../sales/data/link_requests_provider.dart'; // <-- FIXED
import '../../sales/data/link_requets_model.dart'; // <-- FIXED

import '../../sales/data/link_requests_provider.dart';

class SupplierDetailsScreen extends ConsumerWidget {
  final Supplier supplier;

  const SupplierDetailsScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkedList = ref.watch(linkedSuppliersProvider);
    final linkedSupplier = linkedList.firstWhere(
      (s) => s.id == supplier.id,
      orElse: () => supplier,
    );

    final status = linkedSupplier.status; // UPDATED STATUS

    return Scaffold(
      appBar: AppBar(title: Text(supplier.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Supplier info
            if (supplier.logoUrl != null)
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(supplier.logoUrl!),
                ),
              ),
            const SizedBox(height: 20),

            Text(
              supplier.description ?? "No description",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // STATUS BADGE
            _statusBadge(status),
            const SizedBox(height: 20),

            // ACTION BUTTON
            _buildActionButton(context, ref, linkedSupplier),
          ],
        ),
      ),
    );
  }

  /// -------------------------------------------------------------
  /// STATUS BADGE
  /// -------------------------------------------------------------
  Widget _statusBadge(SupplierLinkStatus status) {
    Color color;
    String label;

    switch (status) {
      case SupplierLinkStatus.notLinked:
        color = Colors.grey;
        label = "Not Linked";
        break;

      case SupplierLinkStatus.pending:
        color = Colors.orange;
        label = "Pending Approval";
        break;

      case SupplierLinkStatus.linked:
        color = Colors.green;
        label = "Linked";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: color)),
    );
  }

  /// -------------------------------------------------------------
  /// ACTION BUTTON (Send Request / Cancel / Unlink)
  /// -------------------------------------------------------------
  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    Supplier supplier,
  ) {
    final status = supplier.status;

    // NOT LINKED → send request
    if (status == SupplierLinkStatus.notLinked) {
      return ElevatedButton(
        onPressed: () {
          // 1) Update consumer side → supplier becomes pending
          ref.read(linkedSuppliersProvider.notifier).sendRequest(supplier);

          // 2) Add request to sales list
          ref
              .read(linkRequestsProvider.notifier)
              .addRequest(
                consumerName: "Consumer User",
                consumerEmail: "consumer@test.com",
                supplier: supplier,
              );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Request sent to supplier")),
          );
        },
        child: const Text("Send Link Request"),
      );
    }

    // PENDING → disable button
    if (status == SupplierLinkStatus.pending) {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        child: const Text("Pending Approval"),
      );
    }

    // LINKED → unlink
    return ElevatedButton(
      onPressed: () {
        ref.read(linkedSuppliersProvider.notifier).removeSupplier(supplier.id);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Supplier unlinked")));
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text("Unlink Supplier"),
    );
  }
}
