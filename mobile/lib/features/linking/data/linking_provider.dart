import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'linking_state.dart';

class LinkingNotifier extends StateNotifier<LinkingState> {
  LinkingNotifier() : super(LinkingState(linkedSupplierIds: {}));

  void linkSupplier(String id) {
    final newSet = {...state.linkedSupplierIds, id};
    state = state.copyWith(linkedSupplierIds: newSet);
  }

  void unlinkSupplier(String id) {
    final newSet = {...state.linkedSupplierIds}..remove(id);
    state = state.copyWith(linkedSupplierIds: newSet);
  }

  bool isLinked(String id) {
    return state.linkedSupplierIds.contains(id);
  }
}

final linkingProvider = StateNotifierProvider<LinkingNotifier, LinkingState>((
  ref,
) {
  return LinkingNotifier();
});
