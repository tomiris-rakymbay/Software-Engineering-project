import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sales/data/link_requests_provider.dart';
import '../../sales/data/link_requets_model.dart';

class IncomingRequestsScreen extends ConsumerWidget {
  const IncomingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(linkRequestsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Incoming Requests")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final req = requests[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                req.consumerName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${req.consumerEmail}\nSupplier: ${req.supplierName}",
              ),
              isThreeLine: true,
              trailing: _buildActions(context, ref, req),
            ),
          );
        },
      ),
    );
  }

  /// BUTTONS depending on request status
  Widget _buildActions(BuildContext context, WidgetRef ref, LinkRequest req) {
    switch (req.status) {
      case LinkRequestStatus.pending:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: "Approve",
              icon: const Icon(Icons.check_circle, color: Colors.green),
              onPressed: () {
                ref.read(linkRequestsProvider.notifier).approve(req.id, ref);
              },
            ),
            IconButton(
              tooltip: "Reject",
              icon: const Icon(Icons.cancel, color: Colors.red),
              onPressed: () {
                ref.read(linkRequestsProvider.notifier).reject(req.id, ref);
              },
            ),
          ],
        );

      case LinkRequestStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green, size: 28);

      case LinkRequestStatus.rejected:
        return const Icon(Icons.cancel, color: Colors.red, size: 28);
    }
  }
}
