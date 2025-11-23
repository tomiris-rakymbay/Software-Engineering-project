import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/data/auth_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    final authRepo = ref.read(authRepositoryProvider);
    final token = await authRepo.getToken();
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    if (token == null) {
      context.go('/login');
      return;
    }

    final role = await authRepo.getRole();

    if (role == 'consumer') {
      context.go('/consumer/home');
    } else if (role == 'sales') {
      context.go('/sales/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
