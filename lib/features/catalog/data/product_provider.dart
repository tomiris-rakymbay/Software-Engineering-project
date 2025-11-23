import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_model.dart';
import 'dart:math';

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  // CREATE PRODUCT
  void addProduct(String name, double price, int stock, String categoryId) {
    final newProduct = Product(
      id: Random().nextInt(999999).toString(),
      name: name,
      price: price,
      stock: stock,
      categoryId: categoryId,
    );

    state = [...state, newProduct];
  }

  // UPDATE PRODUCT
  void updateProduct(
    String id,
    String name,
    double price,
    int stock,
    String categoryId,
  ) {
    state = [
      for (final p in state)
        if (p.id == id)
          Product(
            id: id,
            name: name,
            price: price,
            stock: stock,
            categoryId: categoryId,
          )
        else
          p,
    ];
  }

  // DELETE PRODUCT
  void removeProduct(String id) {
    state = [
      for (final p in state)
        if (p.id != id) p,
    ];
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
  (ref) => ProductNotifier(),
);
