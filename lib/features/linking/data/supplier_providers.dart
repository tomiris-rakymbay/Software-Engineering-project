import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'supplier_api.dart';
import 'supplier_model.dart';

// API provider
final supplierApiProvider = Provider<SupplierApi>((ref) {
  return SupplierApi();
});

// FutureProvider for supplier list
final suppliersProvider = FutureProvider<List<Supplier>>((ref) async {
  final api = ref.read(supplierApiProvider);
  return api.getSuppliers();
});
