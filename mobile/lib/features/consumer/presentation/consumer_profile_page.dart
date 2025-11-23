// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../auth/data/auth_repository.dart';
// import '../../auth/presentation/login_screen.dart';
// import '../../auth/data/auth_providers.dart';

// class ConsumerProfilePage extends ConsumerWidget {
//   const ConsumerProfilePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final auth = ref.read(authRepositoryProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Profile")),
//       body: FutureBuilder(
//         future: Future.wait([auth.getUserName(), auth.getUserEmail()]),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final name = snapshot.data![0] ?? "Unknown User";
//           final email = snapshot.data![1] ?? "No Email";

//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Profile Header
//                 Row(
//                   children: [
//                     const CircleAvatar(
//                       radius: 35,
//                       child: Icon(Icons.person, size: 40),
//                     ),
//                     const SizedBox(width: 20),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(email, style: const TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 30),

//                 // Settings list
//                 ListTile(
//                   leading: const Icon(Icons.edit),
//                   title: const Text("Edit Profile"),
//                   onTap: () {},
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.settings),
//                   title: const Text("Settings"),
//                   onTap: () {},
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.language),
//                   title: const Text("Change Language"),
//                   onTap: () {},
//                 ),
//                 const Divider(),

//                 const Spacer(),

//                 // LOGOUT BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     onPressed: () async {
//                       await auth.logout();

//                       // Go back to Login Screen
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginScreen()),
//                         (route) => false,
//                       );
//                     },
//                     child: const Text("Logout"),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/data/auth_providers.dart';
import '../data/consumer_profile_provider.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'language_screen.dart';
import 'package:go_router/go_router.dart';

class ConsumerProfilePage extends ConsumerWidget {
  const ConsumerProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authRepositoryProvider);
    final profile = ref.read(consumerProfileProvider);

    return FutureBuilder(
      future: Future.wait([profile.getName(), profile.getEmail()]),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final name = snapshot.data![0];
        final email = snapshot.data![1];

        return Scaffold(
          appBar: AppBar(title: const Text("Profile")),
          body: ListView(
            children: [
              const SizedBox(height: 20),

              // User info
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Edit Profile
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit Profile"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                ),
              ),

              // Language
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Change Language"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LanguageScreen()),
                ),
              ),

              // Settings
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),

              // Logout
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () async {
                  final auth = ref.read(authRepositoryProvider);
                  await auth.logout();
                  context.go('/login');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
