import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_morphism.dart';
import '../../core/widgets/premium_components.dart';

/// Premium Signup Screen with Traveler/Provider Toggle
/// Glassmorphism card with user type selection
class PremiumSignupPage extends StatefulWidget {
  const PremiumSignupPage({super.key});

  @override
  State<PremiumSignupPage> createState() => _PremiumSignupPageState();
}

class _PremiumSignupPageState extends State<PremiumSignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isTraveler = true;
  bool _isLoading = false;

  // Common fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  // Provider fields
  final _businessNameController = TextEditingController();
  final _cityController = TextEditingController();
  String _selectedCategory = 'Hotel';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate signup
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        context.go('/premium');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Title
                const Text(
                  'Create Account',
                  style: AppTextStyles.displayMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join Bedbees today',
                  style: AppTextStyles.subtitle.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 32),
                
                // User Type Toggle
                GlassCard(
                  blur: 20,
                  opacity: 0.25,
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ToggleButton(
                          text: 'Traveler',
                          isSelected: _isTraveler,
                          onTap: () => setState(() => _isTraveler = true),
                        ),
                      ),
                      Expanded(
                        child: _ToggleButton(
                          text: 'Provider',
                          isSelected: !_isTraveler,
                          onTap: () => setState(() => _isTraveler = false),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Signup Form
                GlassCard(
                  blur: 30,
                  opacity: 0.25,
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_isTraveler) ..._buildTravelerFields()
                        else ..._buildProviderFields(),
                        
                        const SizedBox(height: 24),
                        
                        // Signup Button
                        PremiumButton(
                          text: 'Sign Up',
                          onPressed: _handleSignup,
                          isLoading: _isLoading,
                          backgroundColor: Colors.white,
                          textColor: AppColors.gradientBlueEnd,
                        ),
                        const SizedBox(height: 16),
                        
                        // Terms Text
                        Text(
                          'By signing up, you agree to our Terms of Service and Privacy Policy',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white.withOpacity(0.7),
                          ),
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
                      'Already have an account? ',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/premium-login'),
                      child: Text(
                        'Login',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTravelerFields() {
    return [
      PremiumTextField(
        hintText: 'Full Name',
        prefixIcon: Icons.person_outline,
        controller: _nameController,
        isGlass: true,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your name' : null,
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Email',
        prefixIcon: Icons.email_outlined,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        isGlass: true,
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Please enter your email';
          if (!value!.contains('@')) return 'Please enter a valid email';
          return null;
        },
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Phone Number',
        prefixIcon: Icons.phone_outlined,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        isGlass: true,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your phone number' : null,
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Password',
        prefixIcon: Icons.lock_outline,
        controller: _passwordController,
        obscureText: true,
        isGlass: true,
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Please enter a password';
          if (value!.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    ];
  }

  List<Widget> _buildProviderFields() {
    return [
      PremiumTextField(
        hintText: 'Business Name',
        prefixIcon: Icons.business_outlined,
        controller: _businessNameController,
        isGlass: true,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your business name' : null,
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Contact Person Name',
        prefixIcon: Icons.person_outline,
        controller: _nameController,
        isGlass: true,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your name' : null,
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Email',
        prefixIcon: Icons.email_outlined,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        isGlass: true,
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Please enter your email';
          if (!value!.contains('@')) return 'Please enter a valid email';
          return null;
        },
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Phone Number',
        prefixIcon: Icons.phone_outlined,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        isGlass: true,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your phone number' : null,
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'City',
        prefixIcon: Icons.location_city_outlined,
        controller: _cityController,
        isGlass: true,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please enter your city' : null,
      ),
      const SizedBox(height: 16),
      
      // Category Dropdown
      Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            dropdownColor: AppColors.gradientBlueEnd,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
            items: ['Hotel', 'Tour', 'Car Rental', 'Restaurant']
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedCategory = value);
              }
            },
          ),
        ),
      ),
      const SizedBox(height: 16),
      PremiumTextField(
        hintText: 'Password',
        prefixIcon: Icons.lock_outline,
        controller: _passwordController,
        obscureText: true,
        isGlass: true,
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Please enter a password';
          if (value!.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    ];
  }
}

// Toggle Button Widget
class _ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected 
            ? Colors.white 
            : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: AppTextStyles.buttonMedium.copyWith(
            color: isSelected 
              ? AppColors.gradientBlueEnd
              : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
