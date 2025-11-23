import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'link_requets_model.dart';
import '../../linking/data/supplier_model.dart';
import '../../consumer/data/linked_suppliers_provider.dart';

class LinkRequestNotifier extends StateNotifier<List<LinkRequest>> {
  LinkRequestNotifier()
    : super([
        LinkRequest(
          id: "r1",
          consumerName: "Consumer A",
          consumerEmail: "a@test.com",
          supplierId: "s1",
          supplierName: "Supplier PRO",
        ),
        LinkRequest(
          id: "r2",
          consumerName: "Consumer B",
          consumerEmail: "b@test.com",
          supplierId: "s1",
          supplierName: "Supplier PRO",
        ),
      ]);

  // ✅ FIX — add request when consumer sends a link request
  void addRequest({
    required String consumerName,
    required String consumerEmail,
    required Supplier supplier,
  }) {
    final newRequest = LinkRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      consumerName: consumerName,
      consumerEmail: consumerEmail,
      supplierId: supplier.id,
      supplierName: supplier.name,
    );

    state = [...state, newRequest];
  }

  // Approve request
  void approve(String id, WidgetRef ref) {
    final request = state.firstWhere((r) => r.id == id);

    // update request status
    state = [
      for (final r in state)
        if (r.id == id) r.copyWith(status: LinkRequestStatus.approved) else r,
    ];

    // update consumer’s supplier list
    ref.read(linkedSuppliersProvider.notifier).markAsLinked(request.supplierId);
  }

  // Reject request
  void reject(String id, WidgetRef ref) {
    state = [
      for (final r in state)
        if (r.id == id) r.copyWith(status: LinkRequestStatus.rejected) else r,
    ];
  }
}

final linkRequestsProvider =
    StateNotifierProvider<LinkRequestNotifier, List<LinkRequest>>(
      (ref) => LinkRequestNotifier(),
    );
