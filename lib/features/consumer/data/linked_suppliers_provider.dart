// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../linking/data/supplier_model.dart';
// import 'package:supplier_consumer_app/features/sales/data/link_requets_model.dart';

// class LinkedSuppliersNotifier extends StateNotifier<List<Supplier>> {
//   LinkedSuppliersNotifier() : super([]);

//   void sendRequest(Supplier supplier) {
//     state = [
//       ...state.where((s) => s.id != supplier.id),
//       supplier.copyWith(status: SupplierLinkStatus.pending),
//     ];
//   }

//   void cancelRequest(String id) {
//     state = state.where((s) => s.id != id).toList();
//   }

//   void addLinkedSupplier(Supplier supplier) {
//     if (state.any((s) => s.id == supplier.id)) return;
//     state = [...state, supplier.copyWith(status: SupplierLinkStatus.linked)];
//   }

//   void unlinkSupplier(String id) {
//     state = state.where((s) => s.id != id).toList();
//   }

//   void markAsLinked(String supplierId) {
//     state = [
//       for (final s in state)
//         if (s.id == supplierId)
//           s.copyWith(status: SupplierLinkStatus.linked)
//         else
//           s,
//     ];
//   }

//   void approve(String id, WidgetRef ref) {
//     final request = state.firstWhere((r) => r.id == id);

//     // update request status
//     state = [
//       for (final r in state)
//         if (r.id == id) r.copyWith(status: LinkRequestStatus.approved) else r,
//     ];

//     // notify consumer side
//     ref.read(linkedSuppliersProvider.notifier).markAsLinked(request.supplierId);
//   }
// }

// final linkedSuppliersProvider =
//     StateNotifierProvider<LinkedSuppliersNotifier, List<Supplier>>(
//       (ref) => LinkedSuppliersNotifier(),
//     );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../linking/data/supplier_model.dart';
import '../../sales/data/link_requets_model.dart';

/// --------------------------------------------------------
/// Convert sales-side LinkRequestStatus → consumer SupplierLinkStatus
/// --------------------------------------------------------
SupplierLinkStatus mapRequestStatusToSupplierStatus(LinkRequestStatus status) {
  switch (status) {
    case LinkRequestStatus.pending:
      return SupplierLinkStatus.pending;
    case LinkRequestStatus.approved:
      return SupplierLinkStatus.linked;
    case LinkRequestStatus.rejected:
      return SupplierLinkStatus.notLinked;
  }
}

/// --------------------------------------------------------
/// Linked Suppliers State Notifier (Consumer Side)
/// --------------------------------------------------------
class LinkedSuppliersNotifier extends StateNotifier<List<Supplier>> {
  LinkedSuppliersNotifier() : super([]);

  /// Consumer sends request → supplier becomes pending
  void sendRequest(Supplier supplier) {
    final updated = supplier.copyWith(status: SupplierLinkStatus.pending);

    state = [
      for (final s in state)
        if (s.id == supplier.id) updated else s,
      if (!state.any((s) => s.id == supplier.id)) updated,
    ];
  }

  /// Remove from list (rejected or unlinked)
  void removeSupplier(String supplierId) {
    state = [
      for (final s in state)
        if (s.id != supplierId) s,
    ];
  }

  /// Sales approved → update consumer-side supplier status
  void markApproved(String supplierId) {
    state = [
      for (final s in state)
        if (s.id == supplierId)
          s.copyWith(status: SupplierLinkStatus.linked)
        else
          s,
    ];
  }

  /// Sales rejected → update consumer side
  void markRejected(String supplierId) {
    state = [
      for (final s in state)
        if (s.id == supplierId)
          s.copyWith(status: SupplierLinkStatus.notLinked)
        else
          s,
    ];
  }

  void markAsLinked(String supplierId) {
    state = [
      for (final s in state)
        if (s.id == supplierId)
          s.copyWith(status: SupplierLinkStatus.linked)
        else
          s,
    ];
  }
}

/// Provider
final linkedSuppliersProvider =
    StateNotifierProvider<LinkedSuppliersNotifier, List<Supplier>>(
      (ref) => LinkedSuppliersNotifier(),
    );
