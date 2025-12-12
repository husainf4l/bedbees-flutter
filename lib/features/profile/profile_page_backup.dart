import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  // GUEST PROFILE (NOT LOGGED IN) - ULTRA MODERN
  // ============================================
  Widget _buildGuestProfile() {
    return Scaffold(
      backgroundColor: BedbeesColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Premium Hero Header with Gradient
              _buildPremiumHeroHeader(),

              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Premium CTA Buttons
                    _buildPremiumCTAButtons(),

                    const SizedBox(height: 32),

                    // Quick Social Login
                    _buildModernSocialLogin(),

                    const SizedBox(height: 40),

                    // Benefits Cards Grid
                    _buildBenefitsGrid(),

                    const SizedBox(height: 32),

                    // Stats Row
                    _buildStatsRow(),

                    const SizedBox(height: 32),

                    // Guest Menu Options
                    _buildModernGuestMenu(),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildEnhancedBenefits() {
    final benefits = [
      {
        'icon': Icons.bookmark_border_rounded,
        'title': 'Save Favorites',
        'description': 'Never lose track of amazing places',
        'color': BedbeesColors.primaryBlue,
        'gradient': LinearGradient(
          colors: [BedbeesColors.primaryBlue.withOpacity(0.1), BedbeesColors.primaryBlue.withOpacity(0.05)],
        ),
      },
      {
        'icon': Icons.calendar_month_rounded,
        'title': 'Manage Bookings',
        'description': 'All your trips in one place',
        'color': BedbeesColors.coral,
        'gradient': LinearGradient(
          colors: [BedbeesColors.coral.withOpacity(0.1), BedbeesColors.coral.withOpacity(0.05)],
        ),
      },
      {
        'icon': Icons.people_rounded,
        'title': 'Join Shared Trips',
        'description': 'Travel together, save together',
        'color': BedbeesColors.successGreen,
        'gradient': LinearGradient(
          colors: [BedbeesColors.successGreen.withOpacity(0.1), BedbeesColors.successGreen.withOpacity(0.05)],
        ),
      },
      {
        'icon': Icons.flash_on_rounded,
        'title': 'Instant Booking',
        'description': 'Book in seconds with saved details',
        'color': BedbeesColors.sunshineYellow,
        'gradient': LinearGradient(
          colors: [BedbeesColors.sunshineYellow.withOpacity(0.1), BedbeesColors.sunshineYellow.withOpacity(0.05)],
        ),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: BedbeesColors.primaryBlue.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: BedbeesColors.blueGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.stars_rounded,
                  color: BedbeesColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why Join Bedbees?',
                      style: BedbeesTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Unlock exclusive features',
                      style: BedbeesTextStyles.bodySmall.copyWith(
                        color: BedbeesColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...benefits.asMap().entries.map((entry) {
            final index = entry.key;
            final benefit = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < benefits.length - 1 ? 16 : 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: benefit['gradient'] as Gradient,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: (benefit['color'] as Color).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: BedbeesColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: (benefit['color'] as Color).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        benefit['icon'] as IconData,
                        color: benefit['color'] as Color,
                        size: 28,
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
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            benefit['description'] as String,
                            style: BedbeesTextStyles.bodySmall.copyWith(
                              color: BedbeesColors.greyText,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTrustIndicators() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTrustItem(
            icon: Icons.verified_user_rounded,
            value: '100%',
            label: 'Secure',
          ),
          Container(
            width: 1,
            height: 40,
            color: BedbeesColors.greyText.withOpacity(0.2),
          ),
          _buildTrustItem(
            icon: Icons.people_rounded,
            value: '50K+',
            label: 'Users',
          ),
          Container(
            width: 1,
            height: 40,
            color: BedbeesColors.greyText.withOpacity(0.2),
          ),
          _buildTrustItem(
            icon: Icons.star_rounded,
            value: '4.8',
            label: 'Rating',
          ),
        ],
      ),
    );
  }

  Widget _buildTrustItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: BedbeesColors.primaryBlue,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: BedbeesTextStyles.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: BedbeesColors.darkText,
          ),
        ),
        Text(
          label,
          style: BedbeesTextStyles.caption.copyWith(
            color: BedbeesColors.greyText,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestActions() {
    return Column(
      children: [
        Text(
          'EXPLORE WITHOUT ACCOUNT',
          style: BedbeesTextStyles.caption.copyWith(
            color: BedbeesColors.greyText,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildGuestMenuItem(
          Icons.help_outline_rounded,
          'Help Center',
          '24/7 support available',
          () {},
        ),
        _buildGuestMenuItem(
          Icons.info_outline_rounded,
          'About Bedbees',
          'Learn about our mission',
          () {},
        ),
        _buildGuestMenuItem(
          Icons.settings_outlined,
          'App Settings',
          'Customize your experience',
          () {},
        ),
      ],
    );
  }

  Widget _buildBenefitsList() {
    final benefits = [
      {
        'icon': Icons.bookmark_outline_rounded,
        'title': 'Save favorites',
        'description': 'Keep track of places you love',
        'color': BedbeesColors.primaryBlue,
      },
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'View bookings',
        'description': 'Manage all your reservations',
        'color': BedbeesColors.coral,
      },
      {
        'icon': Icons.groups_outlined,
        'title': 'Join shared trips',
        'description': 'Travel with others and save',
        'color': BedbeesColors.successGreen,
      },
      {
        'icon': Icons.flash_on_outlined,
        'title': 'Faster checkout',
        'description': 'Book in seconds with saved info',
        'color': BedbeesColors.sunshineYellow,
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
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: BedbeesColors.sunshineYellow,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'Why sign in?',
                style: BedbeesTextStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (benefit['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        benefit['icon'] as IconData,
                        color: benefit['color'] as Color,
                        size: 28,
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
                          const SizedBox(height: 4),
                          Text(
                            benefit['description'] as String,
                            style: BedbeesTextStyles.bodyMedium.copyWith(
                              color: BedbeesColors.greyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: BedbeesColors.coral,
                        child: Text(
                          'JD',
                          style: BedbeesTextStyles.displayMedium.copyWith(
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
                    // Stats with Cards
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
                  Text(
                    'ACCOUNT',
                    style: BedbeesTextStyles.caption.copyWith(
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    Icons.person_outline,
                    'Edit Profile',
                    'Update your personal information',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.payment_outlined,
                    'Payment Methods',
                    'Manage your payment options',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.notifications_outlined,
                    'Notifications',
                    'Manage notification preferences',
                    () {},
                  ),

                  const SizedBox(height: 24),
                  Text(
                    'BOOKINGS',
                    style: BedbeesTextStyles.caption.copyWith(
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    Icons.calendar_today_outlined,
                    'My Bookings',
                    'View all your reservations',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.history_outlined,
                    'Booking History',
                    'Past trips and experiences',
                    () {},
                  ),

                  const SizedBox(height: 24),
                  Text(
                    'SUPPORT',
                    style: BedbeesTextStyles.caption.copyWith(
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    Icons.help_outline,
                    'Help Center',
                    '24/7 customer support',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.info_outline,
                    'About BedBees',
                    'Learn more about us',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.privacy_tip_outlined,
                    'Privacy Policy',
                    'Your data and privacy',
                    () {},
                  ),

                  const SizedBox(height: 24),
                  Text(
                    'LOYALTY & REWARDS',
                    style: BedbeesTextStyles.caption.copyWith(
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildLoyaltyCard(),

                  const SizedBox(height: 24),
                  Text(
                    'ACHIEVEMENTS',
                    style: BedbeesTextStyles.caption.copyWith(
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAchievements(),

                  const SizedBox(height: 24),
                  Text(
                    'TRAVEL PREFERENCES',
                    style: BedbeesTextStyles.caption.copyWith(
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPreferences(),

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

  Widget _buildLoyaltyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD700), // Gold
            Color(0xFFFFA500), // Orange
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gold Member',
                    style: BedbeesTextStyles.h2.copyWith(
                      color: BedbeesColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Member since 2023',
                    style: BedbeesTextStyles.bodySmall.copyWith(
                      color: BedbeesColors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.workspace_premium_rounded,
                color: BedbeesColors.white,
                size: 48,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Points Balance',
                      style: BedbeesTextStyles.bodySmall.copyWith(
                        color: BedbeesColors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '2,450',
                      style: BedbeesTextStyles.h1.copyWith(
                        color: BedbeesColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: BedbeesColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Redeem',
                    style: BedbeesTextStyles.bodyMedium.copyWith(
                      color: const Color(0xFFFFA500),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Progress to next level
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to Platinum',
                    style: BedbeesTextStyles.bodySmall.copyWith(
                      color: BedbeesColors.white.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    '550 points to go',
                    style: BedbeesTextStyles.bodySmall.copyWith(
                      color: BedbeesColors.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.65,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    BedbeesColors.white,
                  ),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {
        'icon': Icons.flight_takeoff_rounded,
        'title': 'Frequent Flyer',
        'description': '10+ trips completed',
        'color': const Color(0xFF0EA5E9),
        'unlocked': true,
      },
      {
        'icon': Icons.star_rounded,
        'title': 'Top Reviewer',
        'description': '50+ reviews written',
        'color': const Color(0xFFFFD700),
        'unlocked': true,
      },
      {
        'icon': Icons.explore_rounded,
        'title': 'Explorer',
        'description': 'Visited 5 countries',
        'color': const Color(0xFF10B981),
        'unlocked': true,
      },
      {
        'icon': Icons.castle_rounded,
        'title': 'Culture Buff',
        'description': 'Visit 20 museums',
        'color': const Color(0xFF8B5CF6),
        'unlocked': false,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Earned 3 of 4 badges',
                style: BedbeesTextStyles.h4,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(color: BedbeesColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                final unlocked = achievement['unlocked'] as bool;
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: unlocked
                              ? (achievement['color'] as Color).withOpacity(0.1)
                              : BedbeesColors.greyText.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: unlocked
                                ? achievement['color'] as Color
                                : BedbeesColors.greyText,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          achievement['icon'] as IconData,
                          color: unlocked
                              ? achievement['color'] as Color
                              : BedbeesColors.greyText,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        achievement['title'] as String,
                        style: BedbeesTextStyles.caption.copyWith(
                          color: unlocked
                              ? BedbeesColors.darkText
                              : BedbeesColors.greyText,
                          fontWeight:
                              unlocked ? FontWeight.w600 : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Interests',
                style: BedbeesTextStyles.h4,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(color: BedbeesColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPreferenceChip('🏖️ Beach', true),
              _buildPreferenceChip('🏔️ Mountains', true),
              _buildPreferenceChip('🍜 Food Tours', true),
              _buildPreferenceChip('🎨 Art & Culture', true),
              _buildPreferenceChip('🏛️ History', false),
              _buildPreferenceChip('🛍️ Shopping', true),
              _buildPreferenceChip('🎭 Entertainment', false),
              _buildPreferenceChip('⛰️ Adventure', true),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: BedbeesColors.greyText.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
            'Travel Style',
            style: BedbeesTextStyles.h4,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTravelStyleCard(
                  '💎 Luxury',
                  'Premium experiences',
                  true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTravelStyleCard(
                  '💰 Budget',
                  'Value for money',
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? BedbeesColors.primaryBlue.withOpacity(0.1)
            : BedbeesColors.greyText.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected
              ? BedbeesColors.primaryBlue
              : BedbeesColors.greyText.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: BedbeesTextStyles.bodySmall.copyWith(
          color: selected ? BedbeesColors.primaryBlue : BedbeesColors.greyText,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTravelStyleCard(String title, String subtitle, bool selected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: selected
            ? BedbeesColors.primaryBlue.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected
              ? BedbeesColors.primaryBlue
              : BedbeesColors.greyText.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BedbeesTextStyles.bodyMedium.copyWith(
              color:
                  selected ? BedbeesColors.primaryBlue : BedbeesColors.darkText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: BedbeesTextStyles.caption.copyWith(
              color: BedbeesColors.greyText,
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

  Widget _buildPreferences() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Travel Interests',
            style: BedbeesTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPreferenceChip('🏖️ Beaches', true),
              _buildPreferenceChip('🏔️ Mountains', true),
              _buildPreferenceChip('🎨 Culture', false),
              _buildPreferenceChip('🍽️ Food Tours', true),
              _buildPreferenceChip('⚽ Sports', false),
              _buildPreferenceChip('🎭 Entertainment', false),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Travel Style',
            style: BedbeesTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTravelStyleCard(
                  '✨ Luxury',
                  'Premium experiences',
                  true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTravelStyleCard(
                  '💰 Budget',
                  'Value for money',
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================
  // AUTH MODAL
  // ============================================
  void _showAuthModal(BuildContext context, {required bool isLogin}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AuthModalContent(
        isLogin: isLogin,
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
  final bool isLogin;
  final VoidCallback onAuthSuccess;

  const _AuthModalContent({
    required this.isLogin,
    required this.onAuthSuccess,
  });

  @override
  State<_AuthModalContent> createState() => _AuthModalContentState();
}

class _AuthModalContentState extends State<_AuthModalContent> {
  late bool _isLogin;
  bool _isProvider = false;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Elegant Handle Bar
          Container(
            margin: const EdgeInsets.only(top: 16),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: BedbeesColors.greyText.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icon Header
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      gradient: _isLogin 
                          ? BedbeesColors.blueGradient
                          : LinearGradient(
                              colors: [
                                BedbeesColors.coral,
                                BedbeesColors.coral.withOpacity(0.8),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: (_isLogin ? BedbeesColors.primaryBlue : BedbeesColors.coral)
                              .withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isLogin ? Icons.login_rounded : Icons.person_add_rounded,
                      color: BedbeesColors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    _isLogin ? 'Welcome Back!' : 'Join Bedbees',
                    style: BedbeesTextStyles.h1.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _isLogin
                        ? 'Sign in to continue your journey'
                        : 'Create an account to get started',
                    style: BedbeesTextStyles.bodyLarge.copyWith(
                      color: BedbeesColors.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 36),

                  // Form Fields with Modern Design
                  if (!_isLogin) ...[
                    _buildModernTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'John Doe',
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 16),
                  ],

                  _buildModernTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    hint: 'you@example.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  _buildModernTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: '••••••••',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),

                  if (_isLogin) ...[
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: BedbeesTextStyles.bodyMedium.copyWith(
                            color: BedbeesColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],

                  if (!_isLogin) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: BedbeesColors.coral.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: BedbeesColors.coral.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              value: _isProvider,
                              onChanged: (value) {
                                setState(() => _isProvider = value ?? false);
                              },
                              activeColor: BedbeesColors.coral,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Register as Provider',
                                  style: BedbeesTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: BedbeesColors.coral,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Hotel, car rental, tours & more',
                                  style: BedbeesTextStyles.bodySmall.copyWith(
                                    color: BedbeesColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Main Action Button - Premium Design
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: _isLogin
                          ? BedbeesColors.blueGradient
                          : LinearGradient(
                              colors: [
                                BedbeesColors.coral,
                                BedbeesColors.coral.withOpacity(0.8),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (_isLogin ? BedbeesColors.primaryBlue : BedbeesColors.coral)
                              .withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isLogin ? 'Sign In' : 'Create Account',
                                  style: BedbeesTextStyles.h4.copyWith(
                                    color: BedbeesColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: BedbeesColors.white,
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Elegant Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                BedbeesColors.greyText.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'or continue with',
                          style: BedbeesTextStyles.bodySmall.copyWith(
                            color: BedbeesColors.greyText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                BedbeesColors.greyText.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Social Login Buttons - Premium Design
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialLoginButton(
                          icon: Icons.g_mobiledata,
                          label: 'Google',
                          color: const Color(0xFFDB4437),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSocialLoginButton(
                          icon: Icons.apple,
                          label: 'Apple',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Toggle Login/Signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin
                            ? "Don't have an account?"
                            : 'Already have an account?',
                        style: BedbeesTextStyles.bodyMedium.copyWith(
                          color: BedbeesColors.greyText,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _isLogin = !_isLogin);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: Text(
                          _isLogin ? 'Sign Up' : 'Sign In',
                          style: BedbeesTextStyles.bodyMedium.copyWith(
                            color: BedbeesColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (!_isLogin) ...[
                    const SizedBox(height: 16),
                    Text(
                      'By creating an account, you agree to our Terms of Service and Privacy Policy',
                      style: BedbeesTextStyles.caption.copyWith(
                        color: BedbeesColors.greyText,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BedbeesTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: BedbeesColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: BedbeesColors.screenBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: BedbeesColors.greyText.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            style: BedbeesTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: BedbeesColors.greyText.withOpacity(0.5),
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BedbeesColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: BedbeesColors.primaryBlue,
                  size: 20,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: BedbeesColors.screenBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: BedbeesColors.greyText.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 4),
              Text(
                label,
                style: BedbeesTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BedbeesColors.darkText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAuth() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      widget.onAuthSuccess();
    }
  }
}
