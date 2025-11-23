import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supplier_consumer_app/features/consumer/data/linked_suppliers_provider.dart';

import '../../consumer/data/nav_state_provider.dart';
import '../../linking/data/supplier_providers.dart';
import '../../linking/presentation/supplier_card.dart';
import '../../linking/presentation/supplier_list_screen.dart';
import '../../linking/presentation/supplier_details_screen.dart';
import '../../consumer/presentation/consumer_profile_page.dart';

import '../../linking/data/supplier_model.dart';

import '../../consumer/data/notification_provider.dart';

class ConsumerHomeScreen extends ConsumerWidget {
  const ConsumerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(consumerNavIndexProvider);

    final pages = const [
      _HomeOverviewPage(),
      _LinkedSuppliersPage(),
      _NotificationsPage(),
      ConsumerProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Consumer Dashboard")),
      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => ref.read(consumerNavIndexProvider.notifier).state = i,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.link), label: "Suppliers"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

//
//  HOME OVERVIEW PAGE
//
// class _HomeOverviewPage extends StatelessWidget {
//   const _HomeOverviewPage();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Hello, Consumer!",
//             style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//           ),

//           const SizedBox(height: 16),

//           // Summary cards
//           Row(
//             children: [
//               _summaryCard(
//                 title: "Linked Suppliers",
//                 value: "3",
//                 icon: Icons.link,
//                 color: Colors.blue,
//               ),
//               const SizedBox(width: 12),
//               _summaryCard(
//                 title: "Notifications",
//                 value: "5",
//                 icon: Icons.notifications,
//                 color: Colors.orange,
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           // Navigation to SupplierListScreen
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const SupplierListScreen()),
//                 );
//               },
//               icon: const Icon(Icons.add_link),
//               label: const Text("Link New Supplier"),
//             ),
//           ),

//           const SizedBox(height: 24),

//           const Text(
//             "Recent Activity",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),

//           const SizedBox(height: 12),

//           _activityTile("You linked Supplier A", "2 hours ago"),
//           _activityTile("Supplier B updated prices", "1 day ago"),
//           _activityTile("New offer from Supplier C", "3 days ago"),
//         ],
//       ),
//     );
//   }

//   Widget _summaryCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 32, color: color),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(title),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _activityTile(String message, String time) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         leading: const Icon(Icons.history),
//         title: Text(message),
//         subtitle: Text(time),
//       ),
//     );
//   }
// }

class _HomeOverviewPage extends ConsumerWidget {
  const _HomeOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linked = ref.watch(linkedSuppliersProvider);

    final linkedCount = linked
        .where((s) => s.status == SupplierLinkStatus.linked)
        .length;

    final pendingCount = linked
        .where((s) => s.status == SupplierLinkStatus.pending)
        .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello, Consumer!",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // Summary cards
          Row(
            children: [
              _summaryCard(
                title: "Linked Suppliers",
                value: "$linkedCount",
                icon: Icons.link,
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              _summaryCard(
                title: "Notifications",
                value: "$pendingCount",
                icon: Icons.notifications,
                color: Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Navigation to SupplierListScreen
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupplierListScreen()),
                );
              },
              icon: const Icon(Icons.add_link),
              label: const Text("Link New Supplier"),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Recent Activity",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          _activityTile("You linked Supplier A", "2 hours ago"),
          _activityTile("Supplier B updated prices", "1 day ago"),
          _activityTile("New offer from Supplier C", "3 days ago"),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _activityTile(String message, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.history),
        title: Text(message),
        subtitle: Text(time),
      ),
    );
  }
}

//
//  LINKED SUPPLIERS PAGE
//
class _LinkedSuppliersPage extends ConsumerWidget {
  const _LinkedSuppliersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linked = ref.watch(linkedSuppliersProvider);

    if (linked.isEmpty) {
      return const Center(
        child: Text("No linked suppliers yet", style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: linked.length,
      itemBuilder: (context, index) {
        final supplier = linked[index];
        return SupplierCard(
          supplier: supplier,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SupplierDetailsScreen(supplier: supplier),
              ),
            );
          },
        );
      },
    );
  }
}

//
//  NOTIFICATIONS PAGE
//
class _NotificationsPage extends ConsumerWidget {
  const _NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    if (notifications.isEmpty) {
      return const Center(child: Text("No notifications yet"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, i) {
        final n = notifications[i];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(n.message),
            subtitle: Text(
              timeAgo(n.time),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  String timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return "just now";
    if (diff.inHours < 1) return "${diff.inMinutes} minutes ago";
    if (diff.inDays < 1) return "${diff.inHours} hours ago";
    return "${diff.inDays} days ago";
  }
}

//
//  PROFILE PAGE
//
class _ProfilePage extends ConsumerWidget {
  const _ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text("Profile", style: TextStyle(fontSize: 22)));
  }
}
