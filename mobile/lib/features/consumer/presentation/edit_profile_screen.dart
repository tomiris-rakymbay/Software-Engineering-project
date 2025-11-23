import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/consumer_profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(consumerProfileProvider).getName().then((value) {
      _controller.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.read(consumerProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await profile.updateName(_controller.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
