import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product_model.dart';
import '../data/product_provider.dart';
import 'product_form_screen.dart'; // for editing

class ProductDetailsScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Price: \$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 6),

            Text(
              "Stock: ${product.stock}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 6),

            Text(
              "Category ID: ${product.categoryId}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const Spacer(),

            // EDIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit Product"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductFormScreen(isEditing: true, product: product),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // DELETE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Delete Product"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  ref.read(productProvider.notifier).removeProduct(product.id);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
