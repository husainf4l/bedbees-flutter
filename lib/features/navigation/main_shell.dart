import 'package:flutter/material.dart';
import '../../core/widgets/glass_morphism.dart';
import '../home/premium_home_page.dart';
import '../destinations/destinations_list_page.dart';

/// Main App Shell with Glassmorphic Bottom Navigation
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PremiumHomePage(),
    const DestinationsListPage(),
    const Center(child: Text('Bookings')), // Placeholder
    const Center(child: Text('AI Planner')), // Placeholder
    const Center(child: Text('Profile')), // Placeholder
  ];

  final List<GlassNavItem> _navItems = const [
    GlassNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    GlassNavItem(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
      label: 'Explore',
    ),
    GlassNavItem(
      icon: Icons.bookmark_outline,
      activeIcon: Icons.bookmark,
      label: 'Bookings',
    ),
    GlassNavItem(
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome,
      label: 'AI Planner',
    ),
    GlassNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
      ),
    );
  }
}
