// class Product {
//   final String id;
//   final String name;
//   final double price;
//   final int stock;
//   final String categoryId; // NEW

//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.stock,
//     required this.categoryId,
//   });

//   Product copyWith({
//     String? name,
//     double? price,
//     int? stock,
//     String? categoryId,
//   }) {
//     return Product(
//       id: id,
//       name: name ?? this.name,
//       price: price ?? this.price,
//       stock: stock ?? this.stock,
//       categoryId: categoryId ?? this.categoryId,
//     );
//   }
// }
class Product {
  final String id;
  final String supplierId;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String categoryId;

  Product({
    required this.id,
    required this.supplierId,
    required this.name,
    this.description = '',
    required this.price,
    required this.stock,
    required this.categoryId,
  });
}
