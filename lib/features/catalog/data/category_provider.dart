import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'category_model.dart';

final categoryProvider = Provider<List<Category>>((ref) {
  return [
    Category(id: "c1", name: "Beverages"),
    Category(id: "c2", name: "Snacks"),
    Category(id: "c3", name: "Household"),
    Category(id: "c4", name: "Personal Care"),
    Category(id: "c5", name: "Other"),
  ];
});
