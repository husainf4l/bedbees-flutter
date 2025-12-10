import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bedbees Travel Super-App Sidebar Menu
/// Supports both Traveler Mode and Provider Mode
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isTravelerMode = true;
  String _userName = 'Guest User';
  String _userEmail = 'guest@bedbees.com';
  String? _userAvatar;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'Guest User';
      _userEmail = prefs.getString('user_email') ?? 'guest@bedbees.com';
      _userAvatar = prefs.getString('user_avatar');
      final userType = prefs.getString('user_type') ?? 'traveler';
      _isTravelerMode = userType == 'traveler';
    });
  }

  void _toggleMode() {
    setState(() {
      _isTravelerMode = !_isTravelerMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            _buildProfileSection(context),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                child: _isTravelerMode
                    ? _buildTravelerMenu(context)
                    : _buildProviderMenu(context),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            _buildModeToggle(),
            _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  /// ⭐ 1. PROFILE SECTION
  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00C4B3),
            const Color(0xFF00C4B3).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // User Avatar
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage:
                    _userAvatar != null ? NetworkImage(_userAvatar!) : null,
                child: _userAvatar == null
                    ? const Icon(Icons.person, size: 35, color: Color(0xFF00C4B3))
                    : null,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    Text(
                      _userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Email
                    Text(
                      _userEmail,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // "View Profile" Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                context.push('/profile');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'View Profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ⭐ 2. TRAVELER MODE MENU
  Widget _buildTravelerMenu(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        _buildSectionHeader('MAIN NAVIGATION'),
        
        // 🏠 Home
        _buildMenuItem(
          context,
          icon: Icons.home_outlined,
          title: 'Home',
          subtitle: 'Dashboard & search',
          route: '/home',
        ),

        // 🌍 Destinations
        _buildExpandableMenuItem(
          context,
          icon: Icons.public,
          title: 'Destinations',
          subtitle: 'Explore travel guides',
          children: [
            _buildSubMenuItem(context, 'Popular Cities', '/destinations/popular'),
            _buildSubMenuItem(context, 'All Countries', '/destinations/countries'),
            _buildSubMenuItem(context, 'Beaches', '/destinations/category/beaches'),
            _buildSubMenuItem(context, 'Mountains', '/destinations/category/mountains'),
            _buildSubMenuItem(context, 'Culture', '/destinations/category/culture'),
            _buildSubMenuItem(context, 'Adventure', '/destinations/category/adventure'),
          ],
        ),

        // 🏨 Hotels
        _buildExpandableMenuItem(
          context,
          icon: Icons.hotel_outlined,
          title: 'Hotels',
          subtitle: 'Search & book hotels',
          children: [
            _buildSubMenuItem(context, 'Search Hotels', '/hotels'),
            _buildSubMenuItem(context, 'Map View', '/hotels/map'),
            _buildSubMenuItem(context, 'Top Rated', '/hotels/top-rated'),
          ],
        ),

        // 🗺️ Tours & Activities
        _buildExpandableMenuItem(
          context,
          icon: Icons.tour_outlined,
          title: 'Tours & Activities',
          subtitle: 'Walking tours, attractions',
          children: [
            _buildSubMenuItem(context, 'All Tours', '/tours'),
            _buildSubMenuItem(context, 'Walking Tours', '/tours/walking'),
            _buildSubMenuItem(context, 'City Tours', '/tours/city'),
            _buildSubMenuItem(context, 'Attractions', '/tours/attractions'),
            _buildSubMenuItem(context, 'Tickets & Museums', '/tours/tickets'),
          ],
        ),

        // 🚗 Cars & Transport
        _buildExpandableMenuItem(
          context,
          icon: Icons.directions_car_outlined,
          title: 'Cars & Transport',
          subtitle: 'Rentals & transfers',
          children: [
            _buildSubMenuItem(context, 'Car Rentals', '/cars/rentals'),
            _buildSubMenuItem(context, 'Airport Transfers', '/cars/transfers'),
            _buildSubMenuItem(context, 'Daily Drivers', '/cars/drivers'),
          ],
        ),

        // 👥 Shared Trips
        _buildExpandableMenuItem(
          context,
          icon: Icons.people_outline,
          title: 'Shared Trips',
          subtitle: 'Share & join trips',
          children: [
            _buildSubMenuItem(context, 'Find Shared Trips', '/shared-trips'),
            _buildSubMenuItem(context, 'Create Shared Trip', '/shared-trips/create'),
            _buildSubMenuItem(context, 'Join Requests', '/shared-trips/requests'),
          ],
        ),

        // 🤖 AI Trip Planner
        _buildMenuItem(
          context,
          icon: Icons.auto_awesome,
          title: 'AI Trip Planner',
          subtitle: 'Smart travel assistant',
          route: '/ai-planner',
          iconColor: const Color(0xFFFF8C32),
        ),

        const Divider(height: 24, thickness: 1),
        _buildSectionHeader('MY TRAVEL'),

        // ⭐ Wishlists
        _buildExpandableMenuItem(
          context,
          icon: Icons.favorite_outline,
          title: 'Wishlists',
          subtitle: 'Saved items',
          children: [
            _buildSubMenuItem(context, 'Saved Hotels', '/wishlists/hotels'),
            _buildSubMenuItem(context, 'Saved Tours', '/wishlists/tours'),
            _buildSubMenuItem(context, 'Saved Destinations', '/wishlists/destinations'),
            _buildSubMenuItem(context, 'Saved Cars', '/wishlists/cars'),
            _buildSubMenuItem(context, 'All Lists', '/wishlists'),
          ],
        ),

        // 📅 My Bookings
        _buildExpandableMenuItem(
          context,
          icon: Icons.calendar_today_outlined,
          title: 'My Bookings',
          subtitle: 'All reservations',
          children: [
            _buildSubMenuItem(context, 'All Bookings', '/bookings'),
            _buildSubMenuItem(context, 'Hotels', '/bookings/hotels'),
            _buildSubMenuItem(context, 'Tours', '/bookings/tours'),
            _buildSubMenuItem(context, 'Cars', '/bookings/cars'),
            _buildSubMenuItem(context, 'Shared Trips', '/bookings/shared-trips'),
          ],
        ),

        // 💳 Payments
        _buildExpandableMenuItem(
          context,
          icon: Icons.payment_outlined,
          title: 'Payments',
          subtitle: 'Cards & wallet',
          children: [
            _buildSubMenuItem(context, 'Saved Cards', '/payments/cards'),
            _buildSubMenuItem(context, 'Payment History', '/payments/history'),
            _buildSubMenuItem(context, 'Refund Status', '/payments/refunds'),
            _buildSubMenuItem(context, 'Wallet', '/payments/wallet'),
          ],
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  /// ⭐ 3. PROVIDER MODE MENU
  Widget _buildProviderMenu(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        _buildSectionHeader('PROVIDER DASHBOARD'),

        // 📊 Dashboard
        _buildMenuItem(
          context,
          icon: Icons.dashboard_outlined,
          title: 'Dashboard',
          subtitle: 'Overview & analytics',
          route: '/provider/dashboard',
        ),

        // 🏢 My Listings
        _buildExpandableMenuItem(
          context,
          icon: Icons.business_outlined,
          title: 'My Listings',
          subtitle: 'Manage properties',
          children: [
            _buildSubMenuItem(context, 'All Listings', '/provider/listings'),
            _buildSubMenuItem(context, 'Hotels', '/provider/listings/hotels'),
            _buildSubMenuItem(context, 'Tours', '/provider/listings/tours'),
            _buildSubMenuItem(context, 'Cars', '/provider/listings/cars'),
            _buildSubMenuItem(context, 'Add New', '/provider/listings/create'),
          ],
        ),

        // 📋 Bookings & Reservations
        _buildExpandableMenuItem(
          context,
          icon: Icons.book_online_outlined,
          title: 'Bookings',
          subtitle: 'Manage reservations',
          children: [
            _buildSubMenuItem(context, 'All Bookings', '/provider/bookings'),
            _buildSubMenuItem(context, 'Pending', '/provider/bookings/pending'),
            _buildSubMenuItem(context, 'Confirmed', '/provider/bookings/confirmed'),
            _buildSubMenuItem(context, 'Completed', '/provider/bookings/completed'),
            _buildSubMenuItem(context, 'Cancelled', '/provider/bookings/cancelled'),
          ],
        ),

        // 💰 Earnings
        _buildExpandableMenuItem(
          context,
          icon: Icons.attach_money,
          title: 'Earnings',
          subtitle: 'Revenue & payouts',
          children: [
            _buildSubMenuItem(context, 'Overview', '/provider/earnings'),
            _buildSubMenuItem(context, 'Transactions', '/provider/earnings/transactions'),
            _buildSubMenuItem(context, 'Payout History', '/provider/earnings/payouts'),
            _buildSubMenuItem(context, 'Tax Documents', '/provider/earnings/tax'),
          ],
        ),

        // 📊 Analytics
        _buildMenuItem(
          context,
          icon: Icons.analytics_outlined,
          title: 'Analytics',
          subtitle: 'Performance insights',
          route: '/provider/analytics',
        ),

        // ⭐ Reviews
        _buildMenuItem(
          context,
          icon: Icons.star_outline,
          title: 'Reviews',
          subtitle: 'Customer feedback',
          route: '/provider/reviews',
        ),

        // 💬 Messages
        _buildMenuItem(
          context,
          icon: Icons.message_outlined,
          title: 'Messages',
          subtitle: 'Customer inquiries',
          route: '/provider/messages',
          badge: '3',
        ),

        // 📅 Calendar
        _buildMenuItem(
          context,
          icon: Icons.calendar_month_outlined,
          title: 'Availability Calendar',
          subtitle: 'Manage availability',
          route: '/provider/calendar',
        ),

        // ⚙️ Settings
        _buildExpandableMenuItem(
          context,
          icon: Icons.settings_outlined,
          title: 'Settings',
          subtitle: 'Business preferences',
          children: [
            _buildSubMenuItem(context, 'Business Profile', '/provider/settings/profile'),
            _buildSubMenuItem(context, 'Policies', '/provider/settings/policies'),
            _buildSubMenuItem(context, 'Payment Methods', '/provider/settings/payments'),
            _buildSubMenuItem(context, 'Notifications', '/provider/settings/notifications'),
          ],
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  /// Menu Item with Icon, Title, Subtitle
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
    Color? iconColor,
    String? badge,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (iconColor ?? const Color(0xFF00C4B3)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFF00C4B3),
          size: 22,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFF8C32),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF777777),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        context.push(route);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  /// Expandable Menu Item with Children
  Widget _buildExpandableMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF00C4B3).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF00C4B3),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF777777),
          ),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        childrenPadding: const EdgeInsets.only(left: 40, bottom: 8),
        children: children,
      ),
    );
  }

  /// Sub Menu Item
  Widget _buildSubMenuItem(BuildContext context, String title, String route) {
    return ListTile(
      leading: const Icon(
        Icons.circle,
        size: 6,
        color: Color(0xFF777777),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      dense: true,
      onTap: () {
        Navigator.pop(context);
        context.push(route);
      },
    );
  }

  /// Section Header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF777777),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  /// Mode Toggle (Traveler ↔ Provider)
  Widget _buildModeToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _isTravelerMode
                    ? const Color(0xFF00C4B3)
                    : const Color(0xFFF5F5F5),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(8),
                ),
                border: Border.all(
                  color: _isTravelerMode
                      ? const Color(0xFF00C4B3)
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  if (!_isTravelerMode) _toggleMode();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flight_takeoff,
                      size: 18,
                      color: _isTravelerMode ? Colors.white : const Color(0xFF777777),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Traveler',
                      style: TextStyle(
                        color: _isTravelerMode ? Colors.white : const Color(0xFF777777),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: !_isTravelerMode
                    ? const Color(0xFFFF8C32)
                    : const Color(0xFFF5F5F5),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(8),
                ),
                border: Border.all(
                  color: !_isTravelerMode
                      ? const Color(0xFFFF8C32)
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  if (_isTravelerMode) _toggleMode();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business,
                      size: 18,
                      color: !_isTravelerMode ? Colors.white : const Color(0xFF777777),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Provider',
                      style: TextStyle(
                        color: !_isTravelerMode ? Colors.white : const Color(0xFF777777),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Actions (Settings, Help, Logout)
  Widget _buildBottomActions(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.settings_outlined, color: Color(0xFF777777)),
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          dense: true,
          onTap: () {
            Navigator.pop(context);
            context.push('/settings');
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline, color: Color(0xFF777777)),
          title: const Text(
            'Help & Support',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          dense: true,
          onTap: () {
            Navigator.pop(context);
            context.push('/support');
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Color(0xFFFF3B30)),
          title: const Text(
            'Logout',
            style: TextStyle(fontSize: 14, color: Color(0xFFFF3B30)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          dense: true,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
                context.go('/');
              }
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ),
        ],
      ),
    );
  }
}
