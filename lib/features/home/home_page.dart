import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../navigation/app_drawer.dart';
import '../profile/profile_page.dart';

/// Apple-Style Home Page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const DestinationsTab(),
    const TripsTab(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF00C4B3),
          unselectedItemColor: const Color(0xFF777777),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 24),
              activeIcon: Icon(Icons.home, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 24),
              activeIcon: Icon(Icons.explore, size: 24),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined, size: 24),
              activeIcon: Icon(Icons.calendar_month, size: 24),
              label: 'Trips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 24),
              activeIcon: Icon(Icons.person, size: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

/// Apple-Style Home Tab
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Hero Image Section with Overlaid Search Bar
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // Half page height
            child: Stack(
              children: [
                // Hero Background
                GestureDetector(
                  onTap: () => context.push('/destinations'),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF00C4B3),
                          const Color(0xFF00C4B3).withOpacity(0.9),
                          const Color(0xFFFF8C32).withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Decorative circles
                        Positioned(
                          top: -60,
                          right: -60,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: -50,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -80,
                          left: -40,
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: -30,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF9D162).withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Top Bar with Menu and Notifications
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Search Bar Overlay
                Positioned(
                  top: MediaQuery.of(context).padding.top + 60,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search destinations, hotels...',
                        hintStyle: TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF00C4B3), size: 24),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Categories
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AppleCategoryCard(
                  icon: Icons.hotel_outlined,
                  label: 'Hotels',
                  color: const Color(0xFF00C4B3),
                  onTap: () => context.push('/hotels'),
                ),
                _AppleCategoryCard(
                  icon: Icons.tour_outlined,
                  label: 'Tours',
                  color: const Color(0xFFFF8C32),
                  onTap: () => context.push('/tours'),
                ),
                _AppleCategoryCard(
                  icon: Icons.people_outline,
                  label: 'Shared',
                  color: const Color(0xFFF9D162),
                  onTap: () => context.push('/shared-trips'),
                ),
                _AppleCategoryCard(
                  icon: Icons.flight_outlined,
                  label: 'Flights',
                  color: const Color(0xFF00C4B3),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        // Featured Destination Hero
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _HeroDestinationCard(
              title: 'Paris',
              subtitle: 'The City of Light',
              description: 'Explore the romance and beauty',
              imageGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF00C4B3).withOpacity(0.8),
                  const Color(0xFFFF8C32).withOpacity(0.8),
                ],
              ),
              onTap: () => context.push('/destinations/paris'),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        // Popular Destinations
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Destinations',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    color: Color(0xFF00C4B3),
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/destinations'),
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Color(0xFFFF8C32),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _destinations.length,
              itemBuilder: (context, index) {
                final destination = _destinations[index];
                return _AppleDestinationCard(
                  name: destination['name']!,
                  country: destination['country']!,
                  gradient: destination['gradient'] as LinearGradient,
                  onTap: () => context.push('/destinations/$index'),
                );
              },
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        // Special Offers
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Special Offers',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
                color: Color(0xFF00C4B3),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final offer = _offers[index];
                return _AppleOfferCard(
                  title: offer['title']!,
                  discount: offer['discount']!,
                  description: offer['description']!,
                  color: offer['color'] as Color,
                  icon: offer['icon'] as IconData,
                );
              },
              childCount: _offers.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

/// Apple-Style Category Card
class _AppleCategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AppleCategoryCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Hero Destination Card (Large Featured Card)
class _HeroDestinationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final LinearGradient imageGradient;
  final VoidCallback onTap;

  const _HeroDestinationCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageGradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: imageGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: const NetworkImage('https://source.unsplash.com/800x600/?paris,eiffel'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
            // Content
            Positioned(
              left: 24,
              right: 24,
              bottom: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Apple-Style Destination Card
class _AppleDestinationCard extends StatelessWidget {
  final String name;
  final String country;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _AppleDestinationCard({
    required this.name,
    required this.country,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    country,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Apple-Style Offer Card
class _AppleOfferCard extends StatelessWidget {
  final String title;
  final String discount;
  final String description;
  final Color color;
  final IconData icon;

  const _AppleOfferCard({
    required this.title,
    required this.discount,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            discount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Destinations Tab
class DestinationsTab extends StatelessWidget {
  const DestinationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            title: Text(
              'Explore',
              style: TextStyle(
                color: Color(0xFF00C4B3),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Center(
            child: Text(
              'Destinations coming soon...',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Trips Tab
class TripsTab extends StatelessWidget {
  const TripsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            title: Text(
              'My Trips',
              style: TextStyle(
                color: Color(0xFF00C4B3),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Center(
            child: Text(
              'No trips yet',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Profile Tab
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Color(0xFF00C4B3),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Center(
            child: Text(
              'Profile settings',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Data
final List<Map<String, dynamic>> _destinations = [
  {
    'name': 'Tokyo',
    'country': 'Japan',
    'gradient': const LinearGradient(
      colors: [Color(0xFF00C4B3), Color(0xFFF9D162)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  },
  {
    'name': 'Dubai',
    'country': 'UAE',
    'gradient': const LinearGradient(
      colors: [Color(0xFFFF8C32), Color(0xFFF9D162)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  },
  {
    'name': 'London',
    'country': 'UK',
    'gradient': const LinearGradient(
      colors: [Color(0xFF00C4B3), Color(0xFFFF8C32)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  },
  {
    'name': 'New York',
    'country': 'USA',
    'gradient': const LinearGradient(
      colors: [Color(0xFFF9D162), Color(0xFFFF8C32)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  },
];

final List<Map<String, dynamic>> _offers = [
  {
    'title': 'Summer Hotels',
    'discount': '50% OFF',
    'description': 'Book now and save on beach resorts',
    'color': const Color(0xFFFF8C32),
    'icon': Icons.hotel,
  },
  {
    'title': 'City Tours',
    'discount': '30% OFF',
    'description': 'Explore top destinations worldwide',
    'color': const Color(0xFF00C4B3),
    'icon': Icons.tour,
  },
  {
    'title': 'Group Trips',
    'discount': '25% OFF',
    'description': 'Travel together, save together',
    'color': const Color(0xFFF9D162),
    'icon': Icons.people,
  },
];
