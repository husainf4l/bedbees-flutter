import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/locator.dart';
import '../../../core/utils/validators.dart';
import '../../../services/auth/auth_service.dart';

class BedbeesLoginPage extends StatefulWidget {
  final bool isProvider;

  const BedbeesLoginPage({
    super.key,
    this.isProvider = false,
  });

  @override
  State<BedbeesLoginPage> createState() => _BedbeesLoginPageState();
}

class _BedbeesLoginPageState extends State<BedbeesLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = getIt<AuthService>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        isProvider: widget.isProvider,
      );

      if (!mounted) return;

      if (response.success) {
        context.go(widget.isProvider ? '/provider/dashboard' : '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      
      // Network error - show helpful message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please check your connection or sign up to explore offline.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
                      // Passport illustration
                      SizedBox(
                        height: 120,
                        child: CustomPaint(
                          size: const Size(120, 120),
                          painter: _PassportIllustrationPainter(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Title
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF8C32), // Exact orange
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.isProvider ? 'Provider Account' : 'Traveler Account',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF777777), // Exact grey
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Email field
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        validator: Validators.email,
                      ),
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
                      const SizedBox(height: 12),
                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFF8C32), // Exact orange
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
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
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Sign up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF777777), // Exact grey
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(widget.isProvider
                                  ? '/bedbees/signup?provider=true'
                                  : '/bedbees/signup');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Sign Up',
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
            autofillHints: label == 'Email' 
                ? [AutofillHints.email, AutofillHints.username]
                : label == 'Password'
                    ? [AutofillHints.password]
                    : null,
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

class _PassportIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Teal passport
    paint.color = const Color(0xFF00C4B3);
    final passportRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.15, size.width * 0.6, size.height * 0.7),
      const Radius.circular(8),
    );
    canvas.drawRRect(passportRect, paint);

    // Globe icon
    paint.color = const Color(0xFFF9D162); // Exact yellow
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), size.width * 0.15, paint);

    // Globe lines
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = const Color(0xFFFFCA1F);
    
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), size.width * 0.15, paint);
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.4),
      Offset(size.width * 0.65, size.height * 0.4),
      paint,
    );
    
    final globePath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.4, size.width * 0.5, size.height * 0.55);
    canvas.drawPath(globePath, paint);

    paint.style = PaintingStyle.fill;

    // Orange travel stamp
    paint.color = const Color(0xFFFF8C32).withOpacity(0.6); // Exact orange
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.6, size.height * 0.25, size.width * 0.25, size.height * 0.15),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
