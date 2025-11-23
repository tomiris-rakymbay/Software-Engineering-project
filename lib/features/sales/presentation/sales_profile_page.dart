import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/auth_providers.dart';
import '../../auth/presentation/login_screen.dart';

class SalesProfilePage extends ConsumerWidget {
  const SalesProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authRepositoryProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<String?>>(
          future: Future.wait<String?>([
            auth.getUserName(),
            auth.getUserEmail(),
          ]),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final name = snapshot.data![0] ?? "Unknown";
            final email = snapshot.data![1] ?? "Unknown";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: $name", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text("Email: $email", style: const TextStyle(fontSize: 16)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await auth.logout();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (_) => false,
                    );
                  },
                  child: const Text("Logout"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
