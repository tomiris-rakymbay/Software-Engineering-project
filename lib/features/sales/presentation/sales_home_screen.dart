import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sales_profile_page.dart';
import 'sales_link_requests_screen.dart';

class SalesHomeScreen extends ConsumerWidget {
  const SalesHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = const [SalesLinkRequestsScreen(), SalesProfilePage()];

    final bottomIndex = ValueNotifier<int>(0);

    return ValueListenableBuilder(
      valueListenable: bottomIndex,
      builder: (_, int index, __) {
        return Scaffold(
          appBar: AppBar(title: const Text("Sales Dashboard")),
          body: pages[index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (i) => bottomIndex.value = i,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_search),
                label: "Requests",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
