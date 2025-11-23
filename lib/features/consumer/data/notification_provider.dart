import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../linking/data/supplier_model.dart';
import '../../consumer/data/linked_suppliers_provider.dart';
import '../../sales/data/link_requets_model.dart';
import '../../sales/data/link_requests_provider.dart';
import 'notification_model.dart';

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier(this.ref) : super([]) {
    // Listen for changes
    ref.listen<List<Supplier>>(linkedSuppliersProvider, (previous, next) {
      _checkSupplierChanges(previous, next);
    });

    ref.listen<List<LinkRequest>>(linkRequestsProvider, (previous, next) {
      _checkRequestChanges(previous, next);
    });
  }

  final Ref ref;

  void _checkSupplierChanges(List<Supplier>? prev, List<Supplier> next) {
    if (prev == null) return;

    for (final supplier in next) {
      final before = prev.firstWhere(
        (s) => s.id == supplier.id,
        orElse: () => supplier,
      );

      if (before.status != supplier.status &&
          supplier.status == SupplierLinkStatus.linked) {
        _add("Supplier ${supplier.name} is now linked");
      }
    }
  }

  void _checkRequestChanges(List<LinkRequest>? prev, List<LinkRequest> next) {
    if (prev == null) return;

    for (final r in next) {
      final before = prev.firstWhere((x) => x.id == r.id, orElse: () => r);

      if (before.status != r.status) {
        if (r.status == LinkRequestStatus.approved) {
          _add("Your link request for ${r.supplierName} was approved");
        } else if (r.status == LinkRequestStatus.rejected) {
          _add("Your link request for ${r.supplierName} was rejected");
        }
      }
    }
  }

  void _add(String msg) {
    state = [AppNotification(message: msg, time: DateTime.now()), ...state];
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<AppNotification>>(
      (ref) => NotificationNotifier(ref),
    );
