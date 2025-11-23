import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/consumer_profile_provider.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(consumerProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Change Language")),
      body: FutureBuilder(
        future: profile.getLanguage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final current = snapshot.data!;

          return Column(
            children: [
              RadioListTile(
                value: "en",
                groupValue: current,
                title: const Text("English"),
                onChanged: (_) {
                  profile.setLanguage("en");
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                value: "ru",
                groupValue: current,
                title: const Text("Russian"),
                onChanged: (_) {
                  profile.setLanguage("ru");
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                value: "kk",
                groupValue: current,
                title: const Text("Kazakh"),
                onChanged: (_) {
                  profile.setLanguage("kk");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
