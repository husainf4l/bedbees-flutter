import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../../core/utils/validators.dart';
import '../../../config/locator.dart';
import '../../../services/auth/auth_service.dart';
import '../../../services/api/api_service.dart';
import '../../../config/environment.dart';

class BedbeesSignupPage extends StatefulWidget {
  final bool isProvider;

  const BedbeesSignupPage({
    super.key,
    this.isProvider = false,
  });

  @override
  State<BedbeesSignupPage> createState() => _BedbeesSignupPageState();
}

class _BedbeesSignupPageState extends State<BedbeesSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isProvider = false;

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Spain',
    'Italy',
    'Japan',
    'China',
    'India',
    'Brazil',
    'Mexico',
    'South Africa',
    'Egypt',
    'Saudi Arabia',
    'United Arab Emirates',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _isProvider = widget.isProvider;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = getIt<AuthService>();
      
      ApiResponse response;
      
      try {
        if (_isProvider) {
          // Register as provider
          response = await authService.registerProvider(
            businessName: _nameController.text.trim(),
            category: 'Hotel', // Default category
            country: _countryController.text,
            city: 'N/A', // Can be added later
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
          );
        } else {
          // Register as traveler
          response = await authService.registerTraveler(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            country: _countryController.text,
            preferredLanguage: 'English', // Default language
            password: _passwordController.text,
          );
        }
      } catch (networkError) {
        // Network error - create local account as fallback
        print('🔴 NETWORK ERROR CAUGHT - Creating local account');
        if (!mounted) return;
        
        // Save credentials locally for offline use
        await _saveLocalAccount();
        print('✅ LOCAL ACCOUNT SAVED');
        
        if (!mounted) return;
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created locally! Welcome to Bedbees!'),
            backgroundColor: Color(0xFF00C4B3),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to home page
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        context.go('/home');
        return;
      }

      if (!mounted) return;

      if (response.success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Welcome to Bedbees!'),
            backgroundColor: Color(0xFF00C4B3),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to home page to explore hotels and tours
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        context.go('/home');
      } else {
        // Check if it's a network error
        if (response.error != null && response.error.toString().contains('Connection refused')) {
          print('🔴 NETWORK ERROR DETECTED - Creating local account');
          // Save credentials locally for offline use
          await _saveLocalAccount();
          print('✅ LOCAL ACCOUNT SAVED');
          
          if (!mounted) return;
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created locally! Welcome to Bedbees!'),
              backgroundColor: Color(0xFF00C4B3),
              duration: Duration(seconds: 2),
            ),
          );

          // Navigate to home page
          await Future.delayed(const Duration(milliseconds: 500));
          if (!mounted) return;
          context.go('/home');
        } else {
          // Other error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Signup failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Save account locally when network is unavailable
  Future<void> _saveLocalAccount() async {
    const secureStorage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    
    // Create a mock token for local authentication
    final mockToken = 'local_${_emailController.text.trim()}_${DateTime.now().millisecondsSinceEpoch}';
    
    // Save mock tokens
    await secureStorage.write(
      key: Environment.accessTokenKey,
      value: mockToken,
    );
    await secureStorage.write(
      key: Environment.refreshTokenKey,
      value: mockToken,
    );
    
    // Save user type
    await prefs.setString(
      Environment.userTypeKey,
      _isProvider ? 'provider' : 'traveler',
    );
    
    // Save user data
    final userData = {
      'id': mockToken,
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'country': _countryController.text,
      'isLocal': true, // Flag to indicate this is a local account
    };
    
    await prefs.setString(
      Environment.userDataKey,
      jsonEncode(userData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C4B3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // White rounded card
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Ticket illustration
                      SizedBox(
                        height: 100,
                        child: CustomPaint(
                          size: const Size(200, 100),
                          painter: _TicketIllustrationPainter(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Title
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF8C32), // Exact orange
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF777777), // Exact grey
                        ),
                      ),
                      const SizedBox(height: 24),
                      // User type toggle
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildToggleButton(
                                'Traveler',
                                !_isProvider,
                                () => setState(() => _isProvider = false),
                              ),
                            ),
                            Expanded(
                              child: _buildToggleButton(
                                'Provider',
                                _isProvider,
                                () => setState(() => _isProvider = true),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Full Name field
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email field
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 16),
                      // Phone Number field
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        hint: 'Enter your phone number',
                        icon: Icons.phone_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Country of Residence field
                      _buildCountryDropdown(),
                      const SizedBox(height: 16),
                      // Password field
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Enter your password',
                        icon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        validator: Validators.password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF777777), // Exact grey
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password field
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Re-enter your password',
                        icon: Icons.lock_outline,
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          return Validators.confirmPassword(value, _passwordController.text);
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF777777), // Exact grey
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Create Account button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF8C32), // Exact orange
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                            shadowColor: const Color(0xFFFF8C32).withOpacity(0.3),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF777777), // Exact grey
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/bedbees/login');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFF8C32), // Exact orange
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF8C32) : Colors.transparent, // Exact orange when active
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : const Color(0xFF777777), // White when active, grey when inactive
          ),
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Country of Residence',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _countryController.text.isEmpty ? null : _countryController.text,
            decoration: const InputDecoration(
              hintText: 'Select your country',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFFBDBDBD),
              ),
              prefixIcon: Icon(Icons.public, color: Color(0xFF777777), size: 22),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF212121),
            ),
            dropdownColor: Colors.white,
            items: _countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _countryController.text = newValue ?? '';
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Country is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF212121),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFFBDBDBD),
              ),
              prefixIcon: Icon(icon, color: const Color(0xFF777777), size: 22), // Exact grey
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TicketIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Orange ticket
    paint.color = const Color(0xFFFF8C32); // Exact orange
    final ticketPath = Path()
      ..moveTo(20, size.height * 0.2)
      ..lineTo(size.width - 40, size.height * 0.2)
      ..lineTo(size.width - 40, size.height * 0.8)
      ..lineTo(20, size.height * 0.8)
      ..close();
    canvas.drawPath(ticketPath, paint);

    // Ticket notches
    paint.color = const Color(0xFF00C4B3);
    canvas.drawCircle(Offset(20, size.height * 0.5), 8, paint);
    canvas.drawCircle(Offset(size.width - 40, size.height * 0.5), 8, paint);

    // Dashed line
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = Colors.white.withOpacity(0.5);
    
    final dashPath = Path();
    double dashWidth = 5;
    double dashSpace = 5;
    double startX = 25;
    
    while (startX < size.width - 45) {
      dashPath.moveTo(startX, size.height * 0.5);
      dashPath.lineTo(startX + dashWidth, size.height * 0.5);
      startX += dashWidth + dashSpace;
    }
    canvas.drawPath(dashPath, paint);

    paint.style = PaintingStyle.fill;

    // Airplane icon
    paint.color = Colors.white;
    final planeRect = Rect.fromLTWH(size.width * 0.35, size.height * 0.3, 30, 30);
    canvas.drawOval(planeRect, paint);

    // Yellow tag
    paint.color = const Color(0xFFF9D162); // Exact yellow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.6, size.height * 0.25, 35, 40),
        const Radius.circular(6),
      ),
      paint,
    );

    // Tag hole
    paint.color = const Color(0xFF00C4B3);
    canvas.drawCircle(Offset(size.width * 0.675, size.height * 0.3), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
