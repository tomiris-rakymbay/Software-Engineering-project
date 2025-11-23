// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'supplier_model.dart';

// class SupplierApi {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "https://your-backend-url.com/api", // TODO: set real URL
//       connectTimeout: const Duration(seconds: 10),
//     ),
//   );

//   Future<List<Supplier>> getSuppliers() async {
//     final response = await _dio.get("/suppliers");

//     final body = response.data;

//     List<dynamic> list;

//     // --- CASE 1: backend returns raw JSON text ---
//     if (body is String) {
//       final decoded = jsonDecode(body);

//       if (decoded is List) {
//         list = decoded;
//       } else if (decoded is Map && decoded['data'] is List) {
//         list = decoded['data'];
//       } else {
//         throw Exception(
//           "Unexpected server JSON format: ${decoded.runtimeType}",
//         );
//       }
//     }
//     // --- CASE 2: backend returns JSON List directly ---
//     else if (body is List) {
//       list = body;
//     }
//     // --- CASE 3: backend wraps data inside an object, e.g. { "data": [...] } ---
//     else if (body is Map && body['data'] is List) {
//       list = body['data'];
//     }
//     // --- CASE 4: error ---
//     else {
//       throw Exception("Invalid suppliers response type: ${body.runtimeType}");
//     }

//     // Convert to Supplier objects
//     return list
//         .map((e) => Supplier.fromJson(Map<String, dynamic>.from(e)))
//         .toList();
//   }
// }

import 'dart:async';
import 'supplier_model.dart';

class SupplierApi {
  /// Mock API — returns fake suppliers
  Future<List<Supplier>> getSuppliers() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      Supplier(
        id: "1",
        name: "Fresh Foods Market",
        logoUrl: null,
        description: "Supplier of fresh vegetables and fruits",
      ),
      Supplier(
        id: "2",
        name: "Daily Essentials",
        logoUrl: null,
        description: "Groceries and daily household items",
      ),
      Supplier(
        id: "3",
        name: "Green Supply Co.",
        logoUrl: null,
        description: "Eco-friendly products supplier",
      ),
    ];
  }
}
