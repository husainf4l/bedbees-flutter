import 'package:flutter/material.dart';
import '../../config/locator.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';
import '../../services/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final authService = getIt<AuthService>();
    final authenticated = await authService.isAuthenticated();
    setState(() {
      _isAuthenticated = authenticated;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: BedbeesColors.screenBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _isAuthenticated
        ? _buildAuthenticatedProfile()
        : _buildGuestProfile();
  }

  // ============================================
  // GUEST PROFILE (NOT LOGGED IN)
  // ============================================
  Widget _buildGuestProfile() {
    return Scaffold(
      backgroundColor: BedbeesColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Large User Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: BedbeesColors.primaryBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: BedbeesColors.primaryBlue.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 60,
                    color: BedbeesColors.primaryBlue,
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  'Sign in or create an account',
                  style: BedbeesTextStyles.h1.copyWith(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                Text(
                  'Get the most out of Bedbees',
                  style: BedbeesTextStyles.bodyMedium.copyWith(
                    color: BedbeesColors.greyText,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Primary Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showAuthModal(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BedbeesColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign in / Register',
                      style: BedbeesTextStyles.h4.copyWith(
                        color: BedbeesColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Benefits Section
                _buildBenefitsList(),

                const SizedBox(height: 32),

                // Guest Options (can still explore)
                Text(
                  'BROWSE WITHOUT SIGNING IN',
                  style: BedbeesTextStyles.caption.copyWith(
                    color: BedbeesColors.greyText,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 16),

                _buildGuestMenuItem(
                  Icons.help_outline_rounded,
                  'Help Center',
                  'Get support anytime',
                  () {},
                ),
                _buildGuestMenuItem(
                  Icons.info_outline_rounded,
                  'About Bedbees',
                  'Learn more about us',
                  () {},
                ),
                _buildGuestMenuItem(
                  Icons.settings_outlined,
                  'Settings',
                  'App preferences',
                  () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitsList() {
    final benefits = [
      {
        'icon': Icons.bookmark_outline_rounded,
        'title': 'Save favorites',
        'description': 'Keep track of places you love',
      },
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'View bookings',
        'description': 'Manage all your reservations',
      },
      {
        'icon': Icons.groups_outlined,
        'title': 'Join shared trips',
        'description': 'Travel with others and save',
      },
      {
        'icon': Icons.flash_on_outlined,
        'title': 'Faster checkout',
        'description': 'Book in seconds with saved info',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why sign in?',
            style: BedbeesTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: BedbeesColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        benefit['icon'] as IconData,
                        color: BedbeesColors.primaryBlue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            benefit['title'] as String,
                            style: BedbeesTextStyles.h4.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            benefit['description'] as String,
                            style: BedbeesTextStyles.bodySmall.copyWith(
                              color: BedbeesColors.greyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildGuestMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: BedbeesColors.greyText.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: BedbeesColors.greyText,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: BedbeesTextStyles.h4,
        ),
        subtitle: Text(
          subtitle,
          style: BedbeesTextStyles.bodySmall.copyWith(
            color: BedbeesColors.greyText,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: BedbeesColors.greyText,
        ),
        onTap: onTap,
      ),
    );
  }

  // ============================================
  // AUTHENTICATED PROFILE (LOGGED IN)
  // ============================================
  Widget _buildAuthenticatedProfile() {
    return Scaffold(
      backgroundColor: BedbeesColors.screenBackground,
      body: CustomScrollView(
        slivers: [
          // Profile Header with Gradient
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              decoration: BoxDecoration(
                gradient: BedbeesColors.blueGradient,
                boxShadow: BedbeesColors.mediumShadow,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Profile',
                          style: BedbeesTextStyles.h1.copyWith(
                            color: BedbeesColors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.settings_rounded,
                              color: BedbeesColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Avatar
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: BedbeesColors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: BedbeesColors.coral,
                        child: Text(
                          'JD',
                          style: TextStyle(
                            fontSize: 32,
                            color: BedbeesColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: BedbeesTextStyles.h1.copyWith(
                        color: BedbeesColors.white,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'john.doe@bedbees.com',
                      style: BedbeesTextStyles.bodyMedium.copyWith(
                        color: BedbeesColors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: BedbeesColors.sunshineYellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            color: BedbeesColors.darkText,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Verified Traveler',
                            style: BedbeesTextStyles.caption.copyWith(
                              color: BedbeesColors.darkText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                            '24', 'Trips', Icons.flight_takeoff_rounded),
                        _buildStatCard('68', 'Reviews', Icons.star_rounded),
                        _buildStatCard('15', 'Saved', Icons.bookmark_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Menu Items
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuItem(
                    Icons.calendar_today_outlined,
                    'My Bookings',
                    'View all your reservations',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.bookmark_outline_rounded,
                    'Wishlist',
                    'Saved hotels and tours',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.groups_outlined,
                    'Shared Trips',
                    'Group travel experiences',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.payment_outlined,
                    'Payment Methods',
                    'Manage your payment options',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.person_outline,
                    'Edit Profile',
                    'Update your personal information',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.settings_outlined,
                    'Settings',
                    'App preferences and notifications',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.help_outline,
                    'Help Center',
                    '24/7 customer support',
                    () {},
                  ),

                  const SizedBox(height: 32),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: BedbeesCoralButton(
                      text: 'Logout',
                      onPressed: () => _showLogoutDialog(context),
                      icon: Icons.logout_rounded,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: BedbeesColors.sunshineYellow,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: BedbeesTextStyles.h2.copyWith(
              color: BedbeesColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: BedbeesTextStyles.bodySmall.copyWith(
              color: BedbeesColors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: BedbeesColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: BedbeesColors.primaryBlue,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: BedbeesTextStyles.h4,
        ),
        subtitle: Text(
          subtitle,
          style: BedbeesTextStyles.bodySmall.copyWith(
            color: BedbeesColors.greyText,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: BedbeesColors.greyText,
        ),
        onTap: onTap,
      ),
    );
  }

  // ============================================
  // AUTH MODAL
  // ============================================
  void _showAuthModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AuthModalContent(
        onAuthSuccess: () {
          Navigator.pop(context);
          _checkAuthStatus();
        },
      ),
    );
  }

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
              final authService = getIt<AuthService>();
              await authService.logout();

              if (context.mounted) {
                Navigator.pop(context);
                setState(() {
                  _isAuthenticated = false;
                });
              }
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: BedbeesColors.coral,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// AUTH MODAL CONTENT
// ============================================
class _AuthModalContent extends StatefulWidget {
  final VoidCallback onAuthSuccess;

  const _AuthModalContent({required this.onAuthSuccess});

  @override
  State<_AuthModalContent> createState() => _AuthModalContentState();
}

class _AuthModalContentState extends State<_AuthModalContent> {
  bool _isLogin = true;
  bool _isProvider = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    _isLogin ? 'Welcome to Bedbees' : 'Create Account',
                    style: BedbeesTextStyles.h1.copyWith(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _isLogin
                        ? 'Sign in to access all features'
                        : 'Join Bedbees and start exploring',
                    style: BedbeesTextStyles.bodyMedium.copyWith(
                      color: BedbeesColors.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Form Fields
                  if (!_isLogin) ...[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your name',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  if (!_isLogin) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _isProvider,
                          onChanged: (value) {
                            setState(() => _isProvider = value ?? false);
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Register as provider (hotel, car rental, tours)',
                            style: BedbeesTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Main Action Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle auth
                      widget.onAuthSuccess();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BedbeesColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _isLogin ? 'Sign in' : 'Create account',
                      style: BedbeesTextStyles.h4.copyWith(
                        color: BedbeesColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color: BedbeesColors.greyText.withOpacity(0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or',
                          style: BedbeesTextStyles.bodySmall.copyWith(
                            color: BedbeesColors.greyText,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                              color: BedbeesColors.greyText.withOpacity(0.3))),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Social Login
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 28),
                    label: const Text('Continue with Google'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.apple),
                    label: const Text('Continue with Apple'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Toggle Login/Signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin
                            ? "Don't have an account? "
                            : 'Already have an account? ',
                        style: BedbeesTextStyles.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _isLogin = !_isLogin);
                        },
                        child: Text(
                          _isLogin ? 'Sign up' : 'Sign in',
                          style: BedbeesTextStyles.bodyMedium.copyWith(
                            color: BedbeesColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
