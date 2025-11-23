// import '../../linking/data/supplier_model.dart';

// enum LinkRequestStatus { pending, approved, rejected }

// class LinkRequest {
//   final String id;            // request ID
//   final String consumerName;
//   final String consumerEmail;
//   final String supplierId;
//   final String supplierName;
//   final LinkRequestStatus status;

//   LinkRequest({
//     required this.id,
//     required this.consumerName,
//     required this.consumerEmail,
//     required this.supplierId,
//     required this.supplierName,
//     this.status = LinkRequestStatus.pending,
//   });

//   LinkRequest copyWith({
//     LinkRequestStatus? status,
//   }) {
//     return LinkRequest(
//       id: id,
//       consumerName: consumerName,
//       consumerEmail: consumerEmail,
//       supplierId: supplierId,
//       supplierName: supplierName,
//       status: status ?? this.status,
//     );
//   }
// }
import '../../linking/data/supplier_model.dart';

enum LinkRequestStatus { pending, approved, rejected }

class LinkRequest {
  final String id; // request ID
  final String consumerName;
  final String consumerEmail;
  final String supplierId;
  final String supplierName;
  final LinkRequestStatus status;

  LinkRequest({
    required this.id,
    required this.consumerName,
    required this.consumerEmail,
    required this.supplierId,
    required this.supplierName,
    this.status = LinkRequestStatus.pending,
  });

  LinkRequest copyWith({LinkRequestStatus? status}) {
    return LinkRequest(
      id: id,
      consumerName: consumerName,
      consumerEmail: consumerEmail,
      supplierId: supplierId,
      supplierName: supplierName,
      status: status ?? this.status,
    );
  }
}
