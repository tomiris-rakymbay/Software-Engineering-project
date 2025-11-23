import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_model.dart';
import '../data/product_provider.dart';
import '../../catalog/data/category_provider.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final bool isEditing;
  final Product? product;

  const ProductFormScreen({super.key, this.isEditing = false, this.product});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    final p = widget.product;

    nameController = TextEditingController(text: p?.name ?? "");
    priceController = TextEditingController(text: p?.price.toString() ?? "");
    stockController = TextEditingController(text: p?.stock.toString() ?? "");

    selectedCategory = p?.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);

    // Ensure category is preselected when creating product
    selectedCategory ??= categories.isNotEmpty ? categories.first.id : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? "Edit Product" : "Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),

            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: "Stock Quantity"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // CATEGORY DROPDOWN
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((c) {
                return DropdownMenuItem(value: c.id, child: Text(c.name));
              }).toList(),
              onChanged: (value) {
                setState(() => selectedCategory = value);
              },
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                if (selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a category")),
                  );
                  return;
                }

                if (widget.isEditing) {
                  ref
                      .read(productProvider.notifier)
                      .updateProduct(
                        widget.product!.id,
                        nameController.text,
                        double.parse(priceController.text),
                        int.parse(stockController.text),
                        selectedCategory!,
                      );
                } else {
                  ref
                      .read(productProvider.notifier)
                      .addProduct(
                        nameController.text,
                        double.parse(priceController.text),
                        int.parse(stockController.text),
                        selectedCategory!,
                      );
                }

                Navigator.pop(context);
              },
              child: Text(widget.isEditing ? "Save Changes" : "Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
