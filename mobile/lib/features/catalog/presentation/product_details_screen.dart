// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../data/product_model.dart';
// import '../data/product_provider.dart';
// import 'product_form_screen.dart'; // for editing

// class ProductDetailsScreen extends ConsumerWidget {
//   final Product product;

//   const ProductDetailsScreen({super.key, required this.product});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(title: Text(product.name)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.name,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               "Price: \$${product.price.toStringAsFixed(2)}",
//               style: const TextStyle(fontSize: 18),
//             ),

//             const SizedBox(height: 6),

//             Text(
//               "Stock: ${product.stock}",
//               style: const TextStyle(fontSize: 18),
//             ),

//             const SizedBox(height: 6),

//             Text(
//               "Category ID: ${product.categoryId}",
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),

//             const Spacer(),

//             // EDIT BUTTON
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.edit),
//                 label: const Text("Edit Product"),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           ProductFormScreen(isEditing: true, product: product),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 12),

//             // DELETE BUTTON
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.delete),
//                 label: const Text("Delete Product"),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 onPressed: () {
//                   ref.read(productProvider.notifier).removeProduct(product.id);
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../catalog/data/product_model.dart';
import '../../orders/data/order_model.dart';
import '../../orders/data/order_provider.dart';
import '../../auth/data/auth_providers.dart'; // to get consumer id/name

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _State();
}

class _State extends ConsumerState<ProductDetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            const SizedBox(height: 12),
            Text("Price: ${product.price.toStringAsFixed(2)}"),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: qty > 1 ? () => setState(() => qty--) : null,
                  icon: const Icon(Icons.remove),
                ),
                Text("$qty"),
                IconButton(
                  onPressed: product.stock > qty
                      ? () => setState(() => qty++)
                      : null,
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(width: 12),
                Text("Stock: ${product.stock}"),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // get consumer id (from auth provider)
                final auth = ref.read(authRepositoryProvider);
                final consumerId = await auth.getUserId(); // ensure this exists
                final orderId = DateTime.now().millisecondsSinceEpoch
                    .toString();

                final order = Order(
                  id: orderId,
                  supplierId: product.supplierId,
                  consumerId: consumerId,
                  items: [OrderItem(productId: product.id, qty: qty)],
                );

                ref.read(orderProvider.notifier).createOrder(order);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Order placed")));

                Navigator.pop(context);
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
