import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/data/auth_providers.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool isLoading = false;

  Future<void> _login() async {
    setState(() => isLoading = true);

    final authRepo = ref.read(authRepositoryProvider);

    final success = await authRepo.login(
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    setState(() => isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
      return;
    }

    final role = await authRepo.getRole();

    if (role == "consumer") {
      context.go('/consumer/home');
    } else if (role == "sales") {
      context.go('/sales/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailCtrl,
          decoration: InputDecoration(
            labelText: "email".tr(),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passCtrl,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "password".tr(),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _login,
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text("sign_in".tr()),
          ),
        ),
      ],
    );
  }
}
