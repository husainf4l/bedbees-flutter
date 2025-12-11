import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/locator.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';
import '../../services/auth/auth_service.dart';
import '../explore/explore_page.dart';
import '../saved/saved_page.dart';
import '../profile/profile_page_new.dart';
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
      backgroundColor: BedbeesColors.screenBackground,
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
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: BedbeesColors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.menu_rounded,
                          color: BedbeesColors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    // Notification Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: BedbeesColors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: BedbeesColors.white,
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
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: BedbeesColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Main Search Section
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: BedbeesColors.primaryBlue
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.search_rounded,
                                    color: BedbeesColors.primaryBlue,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Where to?',
                                        style: BedbeesTextStyles.h4.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Search destinations, hotels, tours...',
                                        style: BedbeesTextStyles.bodySmall
                                            .copyWith(
                                          color: BedbeesColors.greyText,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Filter Button
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0EA5E9),
                                Color(0xFF0284C7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    BedbeesColors.primaryBlue.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: BedbeesColors.white,
                            size: 24,
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
      backgroundColor: BedbeesColors.screenBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Profile Card
            _buildProfileSection(),

            // Mode Toggle (Traveler / Provider)
            _buildModeToggle(),

            const SizedBox(height: 8),

            // Main Navigation - Scrollable
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

                    const SizedBox(height: 16),
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

                    const SizedBox(height: 16),
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

                    const SizedBox(height: 16),
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

                    const SizedBox(height: 16),
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

                    const SizedBox(height: 16),
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

                    const SizedBox(height: 16),
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

                  const SizedBox(height: 16),
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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: BedbeesColors.blueGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: BedbeesColors.softShadow,
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
                  border: Border.all(color: BedbeesColors.white, width: 2.5),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: BedbeesColors.coral,
                  child: Text(
                    'JD',
                    style: BedbeesTextStyles.h3.copyWith(
                      color: BedbeesColors.white,
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
                    Text(
                      'John Doe',
                      style: BedbeesTextStyles.white(BedbeesTextStyles.h3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@bedbees.com',
                      style: BedbeesTextStyles.white(BedbeesTextStyles.caption),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // View Profile Button
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: BedbeesColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: BedbeesColors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'View Profile',
                    style: BedbeesTextStyles.white(BedbeesTextStyles.label),
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: BedbeesColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
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
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 8),
      child: Text(
        title,
        style: BedbeesTextStyles.overline.copyWith(
          color: BedbeesColors.greyText,
          letterSpacing: 1.2,
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
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive
            ? BedbeesColors.primaryBlue.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? Border.all(color: BedbeesColors.primaryBlue.withOpacity(0.3))
            : null,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive
                ? BedbeesColors.primaryBlue
                : iconColor?.withOpacity(0.1) ?? BedbeesColors.cardBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive
                ? BedbeesColors.white
                : iconColor ?? BedbeesColors.primaryBlue,
          ),
        ),
        title: Text(
          title,
          style: BedbeesTextStyles.label.copyWith(
            color:
                isActive ? BedbeesColors.primaryBlue : BedbeesColors.darkText,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: BedbeesTextStyles.caption.copyWith(fontSize: 11),
              )
            : null,
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor ?? BedbeesColors.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: BedbeesTextStyles.caption.copyWith(
                    color: BedbeesColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              )
            : Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: BedbeesColors.greyText.withOpacity(0.5),
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
  Widget _buildEnhancedBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        boxShadow: [
          BoxShadow(
            color: BedbeesColors.darkText.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: BedbeesColors.primaryBlue,
          unselectedItemColor: BedbeesColors.greyText,
          selectedLabelStyle: BedbeesTextStyles.caption.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
          unselectedLabelStyle: BedbeesTextStyles.caption.copyWith(
            fontSize: 11,
          ),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.home_outlined, 0),
              activeIcon: _buildActiveNavIcon(Icons.home_rounded, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.explore_outlined, 1),
              activeIcon: _buildActiveNavIcon(Icons.explore_rounded, 1),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.bookmark_border_rounded, 2),
              activeIcon: _buildActiveNavIcon(Icons.bookmark_rounded, 2),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildNavIcon(Icons.favorite_border_rounded, 3),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: BedbeesColors.coral,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
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
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildActiveNavIcon(Icons.favorite_rounded, 3),
                  Positioned(
                    right: 8,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: BedbeesColors.coral,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
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
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person_outline_rounded, 4),
              activeIcon: _buildActiveNavIcon(Icons.person_rounded, 4),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Icon(icon, size: 24),
    );
  }

  Widget _buildActiveNavIcon(IconData icon, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: BedbeesColors.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 24),
    );
  }

  // ============================================
  // WISHLIST PAGE
  // ============================================
  Widget _buildWishlistPage() {
    return Scaffold(
      backgroundColor: BedbeesColors.screenBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFF1A1A1A)),
          ),
          IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.filter_list_rounded, color: Color(0xFF1A1A1A)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Stats Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  BedbeesColors.coral,
                  BedbeesColors.coral.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: BedbeesColors.coral.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 120,
                height: 120,
                color: Colors.grey[200],
                child: Icon(categoryIcon, size: 40, color: Colors.grey[400]),
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
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: BedbeesColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          categoryIcon,
                          size: 14,
                          color: BedbeesColors.primaryBlue,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.favorite,
                          color: BedbeesColors.coral,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: BedbeesColors.greyText,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: BedbeesColors.greyText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
