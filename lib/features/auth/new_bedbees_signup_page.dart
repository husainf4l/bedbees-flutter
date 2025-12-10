import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';

/// 📝 BEDBEES SIGNUP PAGE
/// Modern signup with traveler/provider toggle and official design system
class NewBedbeesSignupPage extends StatefulWidget {
  const NewBedbeesSignupPage({super.key});

  @override
  State<NewBedbeesSignupPage> createState() => _NewBedbeesSignupPageState();
}

class _NewBedbeesSignupPageState extends State<NewBedbeesSignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isTraveler = true; // true = traveler, false = provider

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() => _isLoading = false);
      
      if (mounted) {
        // Navigate to home or onboarding
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: BedbeesColors.blueGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Icon
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: BedbeesColors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.luggage_rounded,
                      size: 64,
                      color: BedbeesColors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Welcome Text
                  Text(
                    'Join Bedbees',
                    style: BedbeesTextStyles.white(BedbeesTextStyles.displayMedium),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Start your travel adventure today',
                    style: BedbeesTextStyles.white(BedbeesTextStyles.bodyLarge),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Signup Card
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: BedbeesColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: BedbeesColors.mediumShadow,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Traveler/Provider Toggle
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: BedbeesColors.cardBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildToggleButton(
                                    label: 'Traveler',
                                    icon: Icons.flight_rounded,
                                    isSelected: _isTraveler,
                                    onTap: () {
                                      setState(() => _isTraveler = true);
                                    },
                                    color: BedbeesColors.primaryBlue,
                                  ),
                                ),
                                Expanded(
                                  child: _buildToggleButton(
                                    label: 'Provider',
                                    icon: Icons.business_rounded,
                                    isSelected: !_isTraveler,
                                    onTap: () {
                                      setState(() => _isTraveler = false);
                                    },
                                    color: BedbeesColors.coral,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Name Field
                          BedbeesTextField(
                            label: 'Full Name',
                            hint: 'Enter your name',
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: BedbeesColors.greyText,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Email Field
                          BedbeesTextField(
                            label: 'Email',
                            hint: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: BedbeesColors.greyText,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Password Field
                          BedbeesTextField(
                            label: 'Password',
                            hint: 'Create a password',
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: BedbeesColors.greyText,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: BedbeesColors.greyText,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Confirm Password Field
                          BedbeesTextField(
                            label: 'Confirm Password',
                            hint: 'Re-enter your password',
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: BedbeesColors.greyText,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: BedbeesColors.greyText,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 28),
                          
                          // Signup Button (Blue for Traveler, Coral for Provider)
                          _isTraveler
                              ? BedbeesButton(
                                  text: 'Create Account',
                                  onPressed: _handleSignup,
                                  isLoading: _isLoading,
                                  icon: Icons.arrow_forward_rounded,
                                )
                              : BedbeesCoralButton(
                                  text: 'Create Provider Account',
                                  onPressed: _handleSignup,
                                  isLoading: _isLoading,
                                  icon: Icons.arrow_forward_rounded,
                                ),
                          
                          const SizedBox(height: 20),
                          
                          // Terms Text
                          Text(
                            'By creating an account, you agree to our Terms of Service and Privacy Policy',
                            style: BedbeesTextStyles.caption,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: BedbeesTextStyles.white(BedbeesTextStyles.bodyMedium),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to login
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Login',
                          style: BedbeesTextStyles.bodyMedium.copyWith(
                            color: BedbeesColors.sunshineYellow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? BedbeesColors.white : BedbeesColors.greyText,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: BedbeesTextStyles.label.copyWith(
                color: isSelected ? BedbeesColors.white : BedbeesColors.greyText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
