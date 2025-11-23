import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../catalog/data/product_provider.dart';
import '../../catalog/data/product_model.dart';
import '../../linking/data/supplier_model.dart';
import '../../consumer/data/linked_suppliers_provider.dart';
import 'product_details_screen.dart';

class ConsumerCatalogScreen extends ConsumerWidget {
  final String supplierId;
  final String supplierName;

  const ConsumerCatalogScreen({
    super.key,
    required this.supplierId,
    required this.supplierName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linked = ref.watch(linkedSuppliersProvider);
    final isLinked = linked.any((s) => s.id == supplierId);

    if (!isLinked) {
      return Scaffold(
        appBar: AppBar(title: Text(supplierName)),
        body: const Center(
          child: Text("You must link with this supplier to view the catalog."),
        ),
      );
    }

    final products = ref.watch(productProvider);
    final supplierProducts = products
        .where((p) => p.supplierId == supplierId)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("$supplierName Catalog")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: supplierProducts.length,
        itemBuilder: (_, i) {
          final p = supplierProducts[i];
          return ListTile(
            title: Text(p.name),
            subtitle: Text("${p.price.toStringAsFixed(2)} • Stock: ${p.stock}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(product: p),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
