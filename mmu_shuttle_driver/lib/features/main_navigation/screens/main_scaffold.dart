import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/features/main_navigation/widgets/app_bar.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  void _onTap(index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "MMU Bus Tracker (Driver)",
        subtitle: "Real-time campus transport",
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "Routes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: "Announcements",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTap(index),
      ),
    );
  }
}
