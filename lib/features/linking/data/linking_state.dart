class LinkingState {
  final Set<String> linkedSupplierIds;

  LinkingState({required this.linkedSupplierIds});

  LinkingState copyWith({Set<String>? linkedSupplierIds}) {
    return LinkingState(
      linkedSupplierIds: linkedSupplierIds ?? this.linkedSupplierIds,
    );
  }
}
