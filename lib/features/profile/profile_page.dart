import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/locator.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';
import '../../services/auth/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                color: BedbeesColors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
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
                          ],
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

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: BedbeesTextStyles.h2.copyWith(
            color: BedbeesColors.white,
            fontWeight: FontWeight.bold,
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
