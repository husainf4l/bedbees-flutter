import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/locator.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';
import '../../services/auth/auth_service.dart';
import '../explore/explore_page.dart';
import '../saved/saved_page.dart';
import '../profile/profile_page.dart';
import '../hotels/hotels_page.dart';
import '../apartments/apartments_page.dart';
import '../car_rental/car_rental_page.dart';
import '../taxi/taxi_services_page.dart';
import '../tour_guides/tour_guides_page.dart';
import '../tours/tours_page.dart';
import '../shared_tours/shared_tours_page.dart';

/// 🏠 BEDBEES HOME SCREEN
/// Modern travel super-app home with official design system
class BedbeesHomePage extends StatefulWidget {
  const BedbeesHomePage({super.key});

  @override
  State<BedbeesHomePage> createState() => _BedbeesHomePageState();
}

class _BedbeesHomePageState extends State<BedbeesHomePage> {
  int _selectedTab = 0;
  String _selectedCategory = 'Hotels';
  bool _isTravelerMode = true; // true = Traveler, false = Provider
  final TextEditingController _searchController = TextEditingController();

  // Pages for bottom navigation
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomePage(),
      const ExplorePage(),
      const SavedPage(),
      _buildWishlistPage(),
      const ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: _selectedTab == 0 ? _buildDrawer(context) : null,
      body: IndexedStack(
        index: _selectedTab,
        children: _pages,
      ),
      bottomNavigationBar: _buildEnhancedBottomNavigation(),
    );
  }

  // ============================================
  // HOME PAGE CONTENT
  // ============================================
  Widget _buildHomePage() {
    return Builder(
      builder: (context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            // Hero Section with Blue Gradient
            _buildHeroSection(context),

            // Main Content
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Category Tabs
                  _buildCategoryTabs(),

                  const SizedBox(height: 24),

                  // Popular Destinations
                  _buildPopularDestinations(),

                  const SizedBox(height: 32),

                  // Featured Deals
                  _buildFeaturedDeals(),

                  const SizedBox(height: 32),

                  // AI Trip Planner CTA
                  _buildAITripPlannerCTA(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // HERO SECTION - Blue Gradient Background
  // ============================================
  Widget _buildHeroSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 500, // Increased to 500 for better photo fit
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hero1.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Light gradient overlay only for text readability (removed blue tint)
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.2),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Menu and Notification
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu Icon
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.menu_rounded,
                          color: Color(0xFF1A1A1A),
                          size: 24,
                        ),
                      ),
                    ),

                    // Notification Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF1A1A1A),
                        size: 24,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Tagline Text
                Text(
                  'The future of travel starts here.',
                  style: BedbeesTextStyles.h2.copyWith(
                    color: BedbeesColors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Enhanced Search Bar
                GestureDetector(
                  onTap: () => _showSearchBottomSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: BedbeesColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: BedbeesColors.primaryBlue,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Where to?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Search destinations, hotels, tours...',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: BedbeesColors.greyText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: BedbeesColors.primaryBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: BedbeesColors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================
  // CATEGORY TABS - Blue + Coral
  // ============================================
  Widget _buildCategoryTabs() {
    final categories = [
      {'name': 'Hotels', 'icon': Icons.hotel_rounded},
      {'name': 'Apartments', 'icon': Icons.apartment_rounded},
      {'name': 'Car Rental', 'icon': Icons.directions_car_rounded},
      {'name': 'Taxi Service', 'icon': Icons.local_taxi_rounded},
      {'name': 'Tour Guides', 'icon': Icons.person_pin_circle_rounded},
      {'name': 'Tours', 'icon': Icons.explore_rounded},
      {'name': 'Share Tours', 'icon': Icons.groups_rounded},
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['name'];

          return BedbeesCategoryChip(
            label: category['name'] as String,
            icon: category['icon'] as IconData,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedCategory = category['name'] as String;
              });
              _navigateToCategory(category['name'] as String);
            },
          );
        },
      ),
    );
  }

  // ============================================
  // NAVIGATION HELPER
  // ============================================
  void _navigateToCategory(String category) {
    Widget page;
    switch (category) {
      case 'Hotels':
        page = const HotelsPage();
        break;
      case 'Apartments':
        page = const ApartmentsPage();
        break;
      case 'Car Rental':
        page = const CarRentalPage();
        break;
      case 'Taxi Service':
        page = const TaxiServicesPage();
        break;
      case 'Tour Guides':
        page = const TourGuidesPage();
        break;
      case 'Tours':
        page = const ToursPage();
        break;
      case 'Share Tours':
        page = const SharedToursPage();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // ============================================
  // POPULAR DESTINATIONS - Coral Badges
  // ============================================
  Widget _buildPopularDestinations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Popular Destinations', style: BedbeesTextStyles.h2),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: BedbeesTextStyles.linkCoral,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300, // Increased to match card height
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _destinations.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final destination = _destinations[index];
              return BedbeesDestinationCard(
                imageUrl: destination['image']!,
                title: destination['title']!,
                location: destination['location']!,
                price: destination['price']!,
                rating: double.parse(destination['rating']!),
                badge: destination['badge'],
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================
  // FEATURED DEALS - Yellow Highlights
  // ============================================
  Widget _buildFeaturedDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Special Offers', style: BedbeesTextStyles.h2),
                  const SizedBox(height: 4),
                  Text(
                    'Limited time deals just for you',
                    style: BedbeesTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildOfferCard(),
        ),
      ],
    );
  }

  Widget _buildOfferCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            BedbeesColors.coral,
            BedbeesColors.coralLight,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: BedbeesColors.coralButtonShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BedbeesBadge(
                  text: '40% OFF',
                  backgroundColor: BedbeesColors.sunshineYellow,
                  textColor: BedbeesColors.darkText,
                ),
                const SizedBox(height: 12),
                Text(
                  'Weekend Getaway\nSpecial',
                  style: BedbeesTextStyles.white(BedbeesTextStyles.h2),
                ),
                const SizedBox(height: 8),
                Text(
                  'Book your weekend escape now',
                  style: BedbeesTextStyles.white(BedbeesTextStyles.bodySmall),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: BedbeesColors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'Book Now',
                    style: BedbeesTextStyles.label.copyWith(
                      color: BedbeesColors.coral,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BedbeesColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.card_giftcard_rounded,
              color: BedbeesColors.white,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // AI TRIP PLANNER CTA - Blue Button
  // ============================================
  Widget _buildAITripPlannerCTA() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: BedbeesColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: BedbeesColors.primaryBlue.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: BedbeesColors.blueGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: BedbeesColors.sunshineYellow,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'AI Trip Planner',
              style: BedbeesTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Let our AI create the perfect itinerary for your next adventure',
              style: BedbeesTextStyles.bodyMedium.copyWith(
                color: BedbeesColors.greyText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            BedbeesButton(
              text: 'Plan My Trip',
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                context.push('/ai-trip-planner');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // DRAWER - Modern Travel Super-App Sidebar
  // ============================================
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Profile Card
            _buildProfileSection(),

            // Mode Toggle (Traveler / Provider)
            _buildModeToggle(),

            const SizedBox(height: 16),

            // Main Navigation - Scrollable
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  if (_isTravelerMode) ...[
                    // TRAVELER MODE NAVIGATION
                    _buildSectionHeader('EXPLORE'),
                    _buildNavItem(
                      icon: Icons.home_rounded,
                      title: 'Home',
                      subtitle: 'Dashboard & recommendations',
                      onTap: () => Navigator.pop(context),
                      isActive: true,
                    ),
                    _buildNavItem(
                      icon: Icons.explore_rounded,
                      title: 'Destinations',
                      subtitle: 'Discover where to go',
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('BOOK'),
                    _buildNavItem(
                      icon: Icons.hotel_rounded,
                      title: 'Hotels',
                      subtitle: 'Find your perfect stay',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.tour_rounded,
                      title: 'Tours & Activities',
                      subtitle: 'Explore experiences',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.directions_car_rounded,
                      title: 'Cars & Transport',
                      subtitle: 'Rental & transfers',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.people_rounded,
                      title: 'Shared Trips',
                      subtitle: 'Join or create group travel',
                      badge: '12 Active',
                      badgeColor: BedbeesColors.coral,
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('PLAN'),
                    _buildNavItem(
                      icon: Icons.auto_awesome_rounded,
                      title: 'AI Trip Planner',
                      subtitle: 'Smart itinerary builder',
                      iconColor: BedbeesColors.sunshineYellow,
                      onTap: () {
                        Navigator.pop(context); // Close drawer
                        context.push('/ai-trip-planner');
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.bookmark_rounded,
                      title: 'Wishlists',
                      subtitle: 'Saved items',
                      badge: '24',
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('MANAGE'),
                    _buildNavItem(
                      icon: Icons.receipt_long_rounded,
                      title: 'My Bookings',
                      subtitle: 'Hotels, tours & more',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.credit_card_rounded,
                      title: 'Payments',
                      subtitle: 'Cards & billing',
                      onTap: () {},
                    ),
                  ] else ...[
                    // PROVIDER MODE NAVIGATION
                    _buildSectionHeader('OVERVIEW'),
                    _buildNavItem(
                      icon: Icons.dashboard_rounded,
                      title: 'Dashboard',
                      subtitle: 'Business overview',
                      onTap: () {},
                      isActive: true,
                    ),
                    _buildNavItem(
                      icon: Icons.analytics_rounded,
                      title: 'Analytics',
                      subtitle: 'Performance metrics',
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('LISTINGS'),
                    _buildNavItem(
                      icon: Icons.business_rounded,
                      title: 'My Properties',
                      subtitle: 'Hotels & listings',
                      badge: '5',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.add_business_rounded,
                      title: 'Add New Listing',
                      subtitle: 'Create property',
                      iconColor: BedbeesColors.coral,
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.tour_rounded,
                      title: 'My Tours',
                      subtitle: 'Activities & experiences',
                      badge: '8',
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('BOOKINGS'),
                    _buildNavItem(
                      icon: Icons.calendar_today_rounded,
                      title: 'Reservations',
                      subtitle: 'Manage bookings',
                      badge: 'New',
                      badgeColor: BedbeesColors.coral,
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.schedule_rounded,
                      title: 'Availability',
                      subtitle: 'Calendar & pricing',
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('BUSINESS'),
                    _buildNavItem(
                      icon: Icons.attach_money_rounded,
                      title: 'Earnings',
                      subtitle: 'Revenue & payouts',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.reviews_rounded,
                      title: 'Reviews',
                      subtitle: 'Guest feedback',
                      onTap: () {},
                    ),
                    _buildNavItem(
                      icon: Icons.message_rounded,
                      title: 'Messages',
                      subtitle: 'Guest communication',
                      badge: '3',
                      badgeColor: BedbeesColors.coral,
                      onTap: () {},
                    ),
                  ],

                  const SizedBox(height: 20),
                  _buildSectionHeader('ACCOUNT'),
                  _buildNavItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'Preferences & privacy',
                    onTap: () {},
                  ),
                  _buildNavItem(
                    icon: Icons.help_rounded,
                    title: 'Help & Support',
                    subtitle: '24/7 assistance',
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // Logout Button
                  _buildLogoutButton(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Section
  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      BedbeesColors.primaryBlue,
                      BedbeesColors.primaryBlueDark,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: BedbeesColors.primaryBlue.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: BedbeesColors.primaryBlue,
                    child: const Text(
                      'JD',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'john.doe@bedbees.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: BedbeesColors.greyText.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // View Profile Button
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BedbeesColors.primaryBlue.withOpacity(0.15),
                    BedbeesColors.primaryBlue.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: BedbeesColors.primaryBlue.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: BedbeesColors.primaryBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: BedbeesColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Mode Toggle
  Widget _buildModeToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildModeButton(
              label: 'Traveler',
              icon: Icons.explore_rounded,
              isSelected: _isTravelerMode,
              onTap: () => setState(() => _isTravelerMode = true),
            ),
          ),
          Expanded(
            child: _buildModeButton(
              label: 'Provider',
              icon: Icons.business_rounded,
              isSelected: !_isTravelerMode,
              onTap: () => setState(() => _isTravelerMode = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? BedbeesColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? BedbeesColors.white : BedbeesColors.greyText,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: BedbeesTextStyles.label.copyWith(
                color:
                    isSelected ? BedbeesColors.white : BedbeesColors.greyText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 12, top: 4),
      child: Text(
        title,
        style: BedbeesTextStyles.overline.copyWith(
          color: BedbeesColors.greyText.withOpacity(0.7),
          letterSpacing: 1.5,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }

  // Navigation Item
  Widget _buildNavItem({
    required IconData icon,
    required String title,
    String? subtitle,
    String? badge,
    Color? badgeColor,
    Color? iconColor,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ]
            : null,
        border: isActive
            ? Border.all(
                color: BedbeesColors.primaryBlue.withOpacity(0.15),
                width: 1,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? LinearGradient(
                            colors: [
                              BedbeesColors.primaryBlue,
                              BedbeesColors.primaryBlueDark,
                            ],
                          )
                        : null,
                    color: isActive
                        ? null
                        : (iconColor?.withOpacity(0.12) ??
                            BedbeesColors.primaryBlue.withOpacity(0.08)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: isActive
                        ? Colors.white
                        : (iconColor ?? BedbeesColors.primaryBlue),
                  ),
                ),
                const SizedBox(width: 16),
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          color: isActive
                              ? BedbeesColors.primaryBlue
                              : const Color(0xFF1A1A1A),
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: BedbeesColors.greyText.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Badge or Arrow
                if (badge != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor ?? BedbeesColors.primaryBlue,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: (badgeColor ?? BedbeesColors.primaryBlue)
                              .withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 22,
                    color: BedbeesColors.greyText.withOpacity(0.4),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Logout Button
  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: BedbeesColors.dangerRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: BedbeesColors.dangerRed.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ListTile(
        onTap: () => _showLogoutDialog(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: BedbeesColors.dangerRed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.logout_rounded,
            size: 20,
            color: BedbeesColors.white,
          ),
        ),
        title: Text(
          'Logout',
          style: BedbeesTextStyles.label.copyWith(
            color: BedbeesColors.dangerRed,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Logout Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: BedbeesColors.greyText),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Call auth service logout
              final authService = getIt<AuthService>();
              await authService.logout();

              if (context.mounted) {
                Navigator.pop(context);
                context.go('/signup');
              }
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: BedbeesColors.dangerRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // ENHANCED BOTTOM NAVIGATION - Blue Active
  // ============================================
  // ============================================
  // MODERN iOS-STYLE BOTTOM NAVIGATION
  // ============================================
  Widget _buildEnhancedBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildModernNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
              ),
              _buildModernNavItem(
                icon: Icons.explore_rounded,
                label: 'Explore',
                index: 1,
              ),
              _buildModernNavItem(
                icon: Icons.bookmark_rounded,
                label: 'Saved',
                index: 2,
              ),
              _buildModernNavItem(
                icon: Icons.favorite_rounded,
                label: 'Wishlist',
                index: 3,
                showBadge: true,
                badgeCount: 3,
              ),
              _buildModernNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool showBadge = false,
    int badgeCount = 0,
  }) {
    final isActive = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: isActive ? 1.0 : 1.0),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Icon(
                          icon,
                          size: 24,
                          color: isActive
                              ? BedbeesColors.primaryBlue
                              : BedbeesColors.greyText.withOpacity(0.6),
                        ),
                      );
                    },
                  ),
                  if (showBadge && badgeCount > 0)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: BedbeesColors.coral,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          badgeCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              // Label text
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? BedbeesColors.primaryBlue
                      : BedbeesColors.greyText.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================
  // WISHLIST PAGE
  // ============================================
  Widget _buildWishlistPage() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.04),
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: BedbeesColors.primaryBlue),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list_rounded,
                  color: BedbeesColors.primaryBlue),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Stats Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  BedbeesColors.primaryBlue,
                  BedbeesColors.primaryBlueDark,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: BedbeesColors.primaryBlue.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWishlistStat('3', 'Hotels', Icons.hotel_rounded),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildWishlistStat('5', 'Tours', Icons.tour_rounded),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildWishlistStat('4', 'Cars', Icons.directions_car_rounded),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Wishlist Items
          _buildWishlistItem(
            'Luxury Beach Resort',
            'Bali, Indonesia',
            '\$299/night',
            'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2',
            Icons.hotel_rounded,
          ),
          const SizedBox(height: 16),
          _buildWishlistItem(
            'Mountain Adventure Tour',
            'Swiss Alps, Switzerland',
            '\$599/person',
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
            Icons.tour_rounded,
          ),
          const SizedBox(height: 16),
          _buildWishlistItem(
            'Paris City Experience',
            'Paris, France',
            '\$449/person',
            'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57',
            Icons.location_city_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistStat(String count, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildWishlistItem(
    String title,
    String location,
    String price,
    String imageUrl,
    IconData categoryIcon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              imageUrl,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BedbeesColors.primaryBlue.withOpacity(0.6),
                      BedbeesColors.primaryBlue,
                    ],
                  ),
                ),
                child: Icon(categoryIcon, size: 45, color: Colors.white),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: BedbeesColors.primaryBlue.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          categoryIcon,
                          size: 16,
                          color: BedbeesColors.primaryBlue,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: BedbeesColors.coral.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: BedbeesColors.coral,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                        color: BedbeesColors.greyText,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: BedbeesColors.greyText,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: BedbeesColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // SEARCH BOTTOM SHEET
  // ============================================
  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: BedbeesColors.screenBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // Handle Bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: BedbeesColors.greyText.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Search Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: BedbeesColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: BedbeesColors.softShadow,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: BedbeesColors.primaryBlue,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Search destinations, hotels...',
                                hintStyle:
                                    BedbeesTextStyles.bodyMedium.copyWith(
                                  color: BedbeesColors.greyText,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: BedbeesColors.greyText,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: BedbeesTextStyles.bodyMedium.copyWith(
                        color: BedbeesColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Search Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Filters
                    Text(
                      'QUICK FILTERS',
                      style: BedbeesTextStyles.caption.copyWith(
                        color: BedbeesColors.greyText,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterChip('🏨 Hotels', Icons.hotel_rounded),
                        _buildFilterChip(
                            '🚗 Car Rental', Icons.directions_car_rounded),
                        _buildFilterChip('🎫 Tours', Icons.explore_rounded),
                        _buildFilterChip(
                            '�️ Beach', Icons.beach_access_rounded),
                        _buildFilterChip('�️ Mountain', Icons.terrain_rounded),
                        _buildFilterChip('🚕 Taxi', Icons.local_taxi_rounded),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Popular Searches
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'POPULAR SEARCHES',
                          style: BedbeesTextStyles.caption.copyWith(
                            color: BedbeesColors.greyText,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Icon(
                          Icons.trending_up_rounded,
                          color: BedbeesColors.coral,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildPopularSearch(
                        'Dubai Desert Safari', Icons.landscape_rounded),
                    _buildPopularSearch(
                        'Burj Khalifa Tours', Icons.apartment_rounded),
                    _buildPopularSearch(
                        'Dubai Marina Cruise', Icons.sailing_rounded),
                    _buildPopularSearch(
                        'Palm Jumeirah Hotels', Icons.hotel_rounded),
                    _buildPopularSearch(
                        'Abu Dhabi Day Trip', Icons.directions_bus_rounded),

                    const SizedBox(height: 32),

                    // Recent Searches
                    Text(
                      'RECENT SEARCHES',
                      style: BedbeesTextStyles.caption.copyWith(
                        color: BedbeesColors.greyText,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildRecentSearch('Luxury hotels in Dubai', Icons.history),
                    _buildRecentSearch('Paris weekend getaway', Icons.history),
                    _buildRecentSearch('Beach resorts Maldives', Icons.history),

                    const SizedBox(height: 32),

                    // Trending Destinations
                    Text(
                      'TRENDING DESTINATIONS',
                      style: BedbeesTextStyles.caption.copyWith(
                        color: BedbeesColors.greyText,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final destinations = [
                            {'name': 'Dubai', 'image': '🏙️', 'deals': '234'},
                            {'name': 'Bali', 'image': '🏖️', 'deals': '189'},
                            {'name': 'Paris', 'image': '🗼', 'deals': '156'},
                            {'name': 'Tokyo', 'image': '🗾', 'deals': '203'},
                            {
                              'name': 'Maldives',
                              'image': '🏝️',
                              'deals': '142'
                            },
                          ];
                          final dest = destinations[index];
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: BedbeesColors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: BedbeesColors.softShadow,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dest['image']!,
                                  style: const TextStyle(fontSize: 48),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  dest['name']!,
                                  style: BedbeesTextStyles.h4,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${dest['deals']} deals',
                                  style: BedbeesTextStyles.caption.copyWith(
                                    color: BedbeesColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: BedbeesColors.primaryBlue.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: BedbeesTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSearch(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: BedbeesColors.coral.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: BedbeesColors.coral,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: BedbeesTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: BedbeesColors.greyText,
          size: 16,
        ),
        onTap: () {
          // Handle search selection
        },
      ),
    );
  }

  Widget _buildRecentSearch(String query, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          icon,
          color: BedbeesColors.greyText,
          size: 20,
        ),
        title: Text(
          query,
          style: BedbeesTextStyles.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: BedbeesColors.greyText,
            size: 18,
          ),
          onPressed: () {
            // Remove from recent searches
          },
        ),
        onTap: () {
          // Handle search selection
        },
      ),
    );
  }
}

// ============================================
// SAMPLE DATA
// ============================================
final List<Map<String, String>> _destinations = [
  {
    'image': 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2',
    'title': 'Bali Paradise',
    'location': 'Indonesia',
    'price': '299',
    'rating': '4.8',
    'badge': 'Trending',
  },
  {
    'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
    'title': 'Swiss Alps',
    'location': 'Switzerland',
    'price': '599',
    'rating': '4.9',
    'badge': 'Most Viewed',
  },
  {
    'image': 'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57',
    'title': 'Paris Romance',
    'location': 'France',
    'price': '449',
    'rating': '4.7',
  },
  {
    'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
    'title': 'Dubai Luxury',
    'location': 'UAE',
    'price': '799',
    'rating': '4.9',
    'badge': 'Popular',
  },
];
