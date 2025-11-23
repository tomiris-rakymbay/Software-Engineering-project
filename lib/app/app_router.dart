import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/splash_screen.dart';

//import '../features/consumer/presentation/consumer_home.dart';
import '../features/sales/presentation/sales_home_screen.dart';

import '../features/linking/presentation/supplier_list_screen.dart';

import '../features/consumer/presentation/consumer_home_screen.dart';
//import '../features/sales/presentation/sales_home_screen.dart';

//import '../features/linking/presentation/supplier_list_screen.dart';

//import 'package:supplier_consumer_app/features/consumer/presentation/consumer_home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    //initialLocation: '/splash',
    initialLocation: '/login',

    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),

      GoRoute(
        path: '/consumer/home',
        builder: (_, __) => const ConsumerHomeScreen(),
      ),
      GoRoute(path: '/sales/home', builder: (_, __) => const SalesHomeScreen()),

      GoRoute(
        path: '/suppliers',
        builder: (_, __) => const SupplierListScreen(),
      ),

      GoRoute(
        path: '/suppliers',
        builder: (_, __) => const SupplierListScreen(),
      ),
    ],
  );
});
