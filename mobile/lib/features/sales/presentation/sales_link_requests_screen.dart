import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sales/data/link_requests_provider.dart';
import '../../sales/data/link_requets_model.dart';

class SalesLinkRequestsScreen extends ConsumerWidget {
  const SalesLinkRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(linkRequestsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Link Requests")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final req = requests[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(req.consumerName),
              subtitle: Text(
                "${req.consumerEmail}\nSupplier: ${req.supplierName}",
              ),
              trailing: _buildActions(context, ref, req),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, LinkRequest req) {
    switch (req.status) {
      case LinkRequestStatus.pending:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                ref.read(linkRequestsProvider.notifier).approve(req.id, ref);
              },
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                ref.read(linkRequestsProvider.notifier).reject(req.id, ref);
              },
            ),
          ],
        );

      case LinkRequestStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green);

      case LinkRequestStatus.rejected:
        return const Icon(Icons.cancel, color: Colors.red);
    }
  }
}
