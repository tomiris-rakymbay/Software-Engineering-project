import 'package:flutter/material.dart';

class SalesDashboardPage extends StatelessWidget {
  const SalesDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales Dashboard")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            const Text(
              "Welcome, Sales!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // SUMMARY CARDS
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    title: "Pending Requests",
                    value: "4", // TODO: dynamic later
                    color: Colors.orange,
                    icon: Icons.inbox,
                    onTap: () {
                      Navigator.pushNamed(context, "/sales/requests");
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    title: "Linked Consumers",
                    value: "12",
                    color: Colors.blue,
                    icon: Icons.people,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ACTION BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/sales/requests");
                },
                icon: const Icon(Icons.inbox),
                label: const Text("View Incoming Requests"),
              ),
            ),

            const SizedBox(height: 30),

            // Today tasks section
            const Text(
              "Today's Tasks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _taskTile("Review 4 pending link requests", "Due today"),
            _taskTile("Send price update to Consumer A", "Due today"),
            _taskTile("Respond to Consumer B inquiry", "Due tomorrow"),
          ],
        ),
      ),
    );
  }

  // ---- UI HELPERS ----

  Widget _statCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
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

  Widget _taskTile(String title, String time) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: Text(title),
        subtitle: Text(time),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
