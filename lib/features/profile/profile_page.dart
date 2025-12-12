import 'package:flutter/material.dart';
import '../../config/locator.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../data/models/user_model.dart';
import '../../services/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isAuthenticated = false;
  bool _isLoading = true;
  UserModel? _user;
  ProviderModel? _provider;
  String? _userType;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authService = getIt<AuthService>();
    final authenticated = await authService.isAuthenticated();
    
    if (authenticated) {
      final userType = await authService.getUserType();
      
      if (userType == 'traveler') {
        final user = await authService.getCurrentUser();
        setState(() {
          _isAuthenticated = true;
          _user = user;
          _userType = userType;
          _isLoading = false;
        });
      } else if (userType == 'provider') {
        final provider = await authService.getCurrentProvider();
        setState(() {
          _isAuthenticated = true;
          _provider = provider;
          _userType = userType;
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isAuthenticated = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: BedbeesColors.screenBackground,
        body: Center(
          child: CircularProgressIndicator(
            color: BedbeesColors.primaryBlue,
          ),
        ),
      );
    }

    return _isAuthenticated
        ? _buildAuthenticatedProfile()
        : _buildGuestProfile();
  }

  // ============================================
  // GUEST PROFILE (NOT LOGGED IN) - MODERN CLEAN
  // ============================================
  Widget _buildGuestProfile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Centered Card Container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // Logo (B icon from splash page)
                    Hero(
                      tag: 'app_logo',
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: BedbeesColors.primaryBlue.withOpacity(0.2),
                              blurRadius: 24,
                              spreadRadius: 0,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: BedbeesColors.primaryBlue.withOpacity(0.1),
                              blurRadius: 12,
                              spreadRadius: -2,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            'assets/images/icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    const Text(
                      'Join Bedbees',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      'Sign in or create an account to unlock all features',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: BedbeesColors.greyText,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/auth/traveler/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BedbeesColors.primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/auth/login');
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: BedbeesColors.primaryBlue,
                          side: BorderSide(
                            color: BedbeesColors.primaryBlue.withOpacity(0.2),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: BedbeesColors.greyText.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontSize: 13,
                              color: BedbeesColors.greyText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: BedbeesColors.greyText.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Social Login Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialButton(
                            icon: Icons.g_mobiledata_rounded,
                            label: 'Google',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSocialButton(
                            icon: Icons.apple_rounded,
                            label: 'Apple',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Benefits List
              _buildBenefitsList(),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // Benefits List
  Widget _buildBenefitsList() {
    return Column(
      children: [
        _buildBenefitItem(
          icon: Icons.favorite_outline_rounded,
          title: 'Save your favorites',
          subtitle: 'Keep track of places you love',
        ),
        const SizedBox(height: 16),
        _buildBenefitItem(
          icon: Icons.calendar_today_outlined,
          title: 'Manage bookings',
          subtitle: 'View and edit your reservations',
        ),
        const SizedBox(height: 16),
        _buildBenefitItem(
          icon: Icons.group_outlined,
          title: 'Join shared trips',
          subtitle: 'Connect with fellow travelers',
        ),
        const SizedBox(height: 16),
        _buildBenefitItem(
          icon: Icons.bolt_outlined,
          title: 'Instant booking',
          subtitle: 'Book faster with saved details',
        ),
      ],
    );
  }

  // Benefit Item
  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: BedbeesColors.greyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Premium Hero Header with Gradient Background
  Widget _buildPremiumHeroHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            BedbeesColors.primaryBlue,
            BedbeesColors.primaryBlue.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          
          // Large Icon with Glow Effect
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (value * 0.2),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // Title
          Text(
            'Join Bedbees',
            style: BedbeesTextStyles.h1.copyWith(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Subtitle
          Text(
            'Unlock exclusive travel experiences',
            style: BedbeesTextStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Premium CTA Buttons
  Widget _buildPremiumCTAButtons() {
    return Column(
      children: [
        // Create Account - Solid Button
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showAuthModal(context, isLogin: false),
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              decoration: BoxDecoration(
                gradient: BedbeesColors.blueGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: BedbeesColors.primaryBlue.withOpacity(0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                height: 56,
                alignment: Alignment.center,
                child: Text(
                  'Create Account',
                  style: BedbeesTextStyles.h4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Sign In - Outlined Button
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showAuthModal(context, isLogin: true),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: BedbeesColors.primaryBlue.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Sign In',
                style: BedbeesTextStyles.h4.copyWith(
                  color: BedbeesColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Modern Social Login
  Widget _buildModernSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: BedbeesColors.greyText.withOpacity(0.2), thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or',
                style: BedbeesTextStyles.bodySmall.copyWith(
                  color: BedbeesColors.greyText,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(child: Divider(color: BedbeesColors.greyText.withOpacity(0.2), thickness: 1)),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _buildSocialButton(
                icon: Icons.g_mobiledata_rounded,
                label: 'Google',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSocialButton(
                icon: Icons.apple_rounded,
                label: 'Apple',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: BedbeesColors.greyText.withOpacity(0.15),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: BedbeesColors.darkText),
              const SizedBox(width: 8),
              Text(
                label,
                style: BedbeesTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Benefits Grid - Modern Cards
  Widget _buildBenefitsGrid() {
    final benefits = [
      {
        'icon': Icons.bookmark_rounded,
        'title': 'Save Favorites',
        'color': BedbeesColors.coral,
      },
      {
        'icon': Icons.calendar_today_rounded,
        'title': 'Manage Bookings',
        'color': BedbeesColors.primaryBlue,
      },
      {
        'icon': Icons.group_rounded,
        'title': 'Join Shared Trips',
        'color': BedbeesColors.successGreen,
      },
      {
        'icon': Icons.flash_on_rounded,
        'title': 'Instant Booking',
        'color': BedbeesColors.sunshineYellow,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: benefits.length,
      itemBuilder: (context, index) {
        final benefit = benefits[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: BedbeesColors.darkText.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (benefit['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  benefit['icon'] as IconData,
                  color: benefit['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                benefit['title'] as String,
                style: BedbeesTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Stats Row
  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: BedbeesColors.darkText.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('100% Secure', Icons.security_rounded),
          Container(
            width: 1,
            height: 30,
            color: BedbeesColors.greyText.withOpacity(0.2),
          ),
          _buildStatItem('50K+ Users', Icons.people_rounded),
          Container(
            width: 1,
            height: 30,
            color: BedbeesColors.greyText.withOpacity(0.2),
          ),
          _buildStatItem('4.8 Rating', Icons.star_rounded),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: BedbeesColors.primaryBlue, size: 24),
        const SizedBox(height: 6),
        Text(
          label,
          style: BedbeesTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Modern Guest Menu
  Widget _buildModernGuestMenu() {
    final menuItems = [
      {'icon': Icons.help_outline_rounded, 'title': 'Help & Support'},
      {'icon': Icons.info_outline_rounded, 'title': 'About Bedbees'},
      {'icon': Icons.language_rounded, 'title': 'Language & Region'},
      {'icon': Icons.settings_outlined, 'title': 'Settings'},
    ];

    return Column(
      children: menuItems.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: BedbeesColors.greyText.withOpacity(0.1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: BedbeesColors.darkText,
                      size: 22,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: BedbeesTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: BedbeesColors.greyText,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Placeholder for authenticated profile
  Widget _buildAuthenticatedProfile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header with user info
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BedbeesColors.primaryBlue,
                      BedbeesColors.primaryBlue.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Picture
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _getUserInitials(),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: BedbeesColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User Name
                    Text(
                      _getUserName(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User Email
                    Text(
                      _getUserEmail(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuSection('Account', [
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'Personal Information',
                        subtitle: 'Manage your account details',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.security_outlined,
                        title: 'Security',
                        subtitle: 'Password and authentication',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Manage your notifications',
                        onTap: () {},
                      ),
                    ]),

                    const SizedBox(height: 24),

                    _buildMenuSection('Bookings', [
                      _buildMenuItem(
                        icon: Icons.hotel_outlined,
                        title: 'My Bookings',
                        subtitle: 'View all your reservations',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.favorite_outline,
                        title: 'Saved Items',
                        subtitle: 'Your favorite destinations',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.history,
                        title: 'Booking History',
                        subtitle: 'Past trips and stays',
                        onTap: () {},
                      ),
                    ]),

                    const SizedBox(height: 24),

                    _buildMenuSection('Preferences', [
                      _buildMenuItem(
                        icon: Icons.language_outlined,
                        title: 'Language',
                        subtitle: _user?.preferredLanguage ?? 'English',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.currency_exchange_outlined,
                        title: 'Currency',
                        subtitle: 'USD',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        subtitle: 'Get assistance',
                        onTap: () {},
                      ),
                    ]),

                    const SizedBox(height: 32),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _handleLogout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.red.withOpacity(0.2)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getUserName() {
    if (_user != null) {
      return _user!.fullName;
    } else if (_provider != null) {
      return _provider!.businessName;
    }
    return 'User';
  }

  String _getUserEmail() {
    if (_user != null) {
      return _user!.email;
    } else if (_provider != null) {
      return _provider!.email;
    }
    return '';
  }

  String _getUserInitials() {
    final name = _getUserName();
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'U';
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: BedbeesColors.greyText,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: BedbeesColors.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
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
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: BedbeesColors.greyText,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: BedbeesColors.greyText.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: BedbeesColors.greyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final authService = getIt<AuthService>();
      await authService.logout();
      
      if (mounted) {
        setState(() {
          _isAuthenticated = false;
          _user = null;
          _provider = null;
          _userType = null;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out successfully'),
            backgroundColor: BedbeesColors.primaryBlue,
          ),
        );
      }
    }
  }

  // Show Auth Modal - Full Screen Modern Page
  void _showAuthModal(BuildContext context, {required bool isLogin}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ModernAuthPage(isLogin: isLogin),
      ),
    );
  }
}

// ============================================
// MODERN AUTH PAGE (FULL SCREEN)
// ============================================
class _ModernAuthPage extends StatefulWidget {
  final bool isLogin;

  const _ModernAuthPage({required this.isLogin});

  @override
  State<_ModernAuthPage> createState() => _ModernAuthPageState();
}

class _ModernAuthPageState extends State<_ModernAuthPage> {
  late bool _isLogin;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: const Color(0xFF1A1A1A),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Skip',
                      style: BedbeesTextStyles.bodyMedium.copyWith(
                        color: BedbeesColors.greyText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // Centered Card Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isLogin ? 'Welcome back' : 'Create Account',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A1A1A),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _isLogin
                                    ? 'Sign in to continue'
                                    : 'Join Bedbees to start exploring',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: BedbeesColors.greyText,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          // Name field (only for signup)
                          if (!_isLogin) ...[
                            _buildInputLabel('Full Name'),
                            const SizedBox(height: 12),
                            _buildTextField(
                              controller: _nameController,
                              hint: 'Enter your full name',
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Email field
                          _buildInputLabel('Email'),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Enter your email',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 24),

                          // Password field
                          _buildInputLabel('Password'),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _passwordController,
                            hint: 'Enter your password',
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: BedbeesColors.greyText,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          // Forgot password (only for login)
                          if (_isLogin) ...[
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 32),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: BedbeesColors.primaryBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 32),

                          // Submit button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BedbeesColors.primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                disabledBackgroundColor:
                                    BedbeesColors.primaryBlue.withOpacity(0.6),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      _isLogin ? 'Sign In' : 'Create Account',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: BedbeesColors.greyText.withOpacity(0.2),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: BedbeesColors.greyText,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: BedbeesColors.greyText.withOpacity(0.2),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Social login buttons
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialLoginButton(
                                  icon: Icons.g_mobiledata_rounded,
                                  label: 'Google',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildSocialLoginButton(
                                  icon: Icons.apple_rounded,
                                  label: 'Apple',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Continue as guest (optional)
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Continue as guest',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: BedbeesColors.greyText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Toggle between sign in and sign up
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isLogin
                                ? "Don't have an account? "
                                : 'Already have an account? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: BedbeesColors.greyText,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              _isLogin ? 'Sign Up' : 'Sign In',
                              style: TextStyle(
                                fontSize: 14,
                                color: BedbeesColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build input labels
  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xFF1A1A1A),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
          color: BedbeesColors.greyText.withOpacity(0.5),
        ),
        prefixIcon: Icon(
          icon,
          color: BedbeesColors.greyText.withOpacity(0.6),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: BedbeesColors.greyText.withOpacity(0.1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: BedbeesColors.greyText.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: BedbeesColors.primaryBlue,
            width: 2,
          ),
        ),
      ),
    );
  }

  // Helper method to build social login buttons
  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
  }) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF1A1A1A),
        side: BorderSide(
          color: BedbeesColors.greyText.withOpacity(0.2),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Handle form submission
  void _handleSubmit() async {
    // Validate fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (!_isLogin && _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = getIt<AuthService>();
      
      if (_isLogin) {
        // Login
        final response = await authService.login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          isProvider: false,
        );

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        if (response.success) {
          // Close the modal and reload the profile page
          Navigator.pop(context);
          
          // Trigger a rebuild of the parent widget
          if (context.findAncestorStateOfType<_ProfilePageState>() != null) {
            context.findAncestorStateOfType<_ProfilePageState>()!._loadUserData();
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signed in successfully!'),
              backgroundColor: BedbeesColors.primaryBlue,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Login failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // For signup, redirect to proper signup page
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please use the complete signup form'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
