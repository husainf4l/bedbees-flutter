import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Showcase page displaying both Welcome and Sign In screens side by side
/// in a high-quality mobile UI design inspired by modern travel apps
class ModernShowcasePage extends StatelessWidget {
  const ModernShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header - Apple Style
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFFE5E5E7).withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      // Back button
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF0ea5e9),
                            size: 18,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      const Spacer(),
                      // Title
                      const Column(
                        children: [
                          Text(
                            'Bedbees',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1D1D1F),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(width: 36), // Balance the back button
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Hero Title Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Modern Travel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1D1D1F),
                        letterSpacing: -1.5,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Experience',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0ea5e9),
                        letterSpacing: -1.5,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'A beautifully crafted interface that makes\ntravel planning effortless and delightful.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF86868B),
                        letterSpacing: -0.2,
                        height: 1.47,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 64),
              const SizedBox(height: 64),

              // Two screens side by side
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 800;
                    
                    if (isMobile) {
                      return Column(
                        children: [
                          _buildWelcomeScreen(),
                          const SizedBox(height: 64),
                          _buildSignInScreen(),
                          const SizedBox(height: 80),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildWelcomeScreen(),
                          const SizedBox(width: 48),
                          _buildSignInScreen(),
                        ],
                      );
                    }
                  },
                ),
              ),
              
              // Footer - Apple Style
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFBFD),
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFFE5E5E7).withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Designed for travelers',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF86868B),
                        letterSpacing: -0.1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.travel_explore,
                          size: 16,
                          color: Color(0xFF0ea5e9),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Bedbees',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0ea5e9),
                            letterSpacing: -0.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return _PhoneMockup(
      label: 'Welcome',
      child: Stack(
        children: [
          // Top section with blue topography pattern
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 480,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0ea5e9),
                    Color(0xFF0284c7),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              child: CustomPaint(
                painter: _TopographyPainter(),
              ),
            ),
          ),

          // Curved wave shape
          Positioned(
            top: 420,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(375, 100),
              painter: _WavePainter(),
            ),
          ),

          // Bottom white section with content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 392,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Title - Apple Typography
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D1D1F),
                      letterSpacing: -1.0,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Subtitle lines - SF Pro style
                  const Text(
                    'Experience seamless travel\nbooking with Bedbees. Your\njourney begins here.',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF86868B),
                      height: 1.47,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  // Continue button - Apple style
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0ea5e9),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0ea5e9).withValues(alpha: 0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 12,
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
          ),
        ],
      ),
    );
  }

  Widget _buildSignInScreen() {
    return _PhoneMockup(
      label: 'Sign In',
      child: Stack(
        children: [
          // Top section with blue topography pattern
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 320,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0ea5e9),
                    Color(0xFF0284c7),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              child: CustomPaint(
                painter: _TopographyPainter(),
              ),
            ),
          ),

          // Curved wave shape
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(375, 100),
              painter: _WavePainter(),
            ),
          ),

          // Bottom white section with form
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 552,
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    // Title with underline - Apple style
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1D1D1F),
                            letterSpacing: -0.8,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0ea5e9),
                                Color(0xFF0284c7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Email field - Apple style
                    _buildTextField(label: 'Email'),
                    const SizedBox(height: 16),

                    // Password field - Apple style
                    _buildTextField(
                      label: 'Password',
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0ea5e9),
                                    Color(0xFF0284c7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Remember Me',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF86868B),
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF0ea5e9),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Login button - Apple style
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF0ea5e9),
                            Color(0xFF0284c7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0ea5e9).withValues(alpha: 0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign up text - Apple style
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF86868B),
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF0ea5e9),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF86868B),
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD2D2D7).withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF1D1D1F),
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              if (isPassword)
                const Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Icon(
                    Icons.visibility_outlined,
                    color: Color(0xFF86868B),
                    size: 22,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final String label;
  final Widget child;

  const _PhoneMockup({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Label - Apple style
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF86868B),
            letterSpacing: 0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        
        // Phone mockup - Enhanced Apple style
        Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: const Color(0xFF1D1D1F),
            borderRadius: BorderRadius.circular(48),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 60,
                offset: const Offset(0, 30),
                spreadRadius: -10,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 40);
    
    // Smooth curve
    path.quadraticBezierTo(
      size.width * 0.25,
      0,
      size.width * 0.5,
      20,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      40,
      size.width,
      20,
    );
    
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TopographyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw organic topography-like contour lines
    for (int i = 0; i < 20; i++) {
      final path = Path();
      final startY = (i * 30.0) - 100;
      
      path.moveTo(-50, startY);
      
      for (double x = -50; x < size.width + 50; x += 20) {
        final y = startY + 
          (20 * (i % 3 == 0 ? 1 : -1) * 
            math.sin(x / 100)) + 
          (15 * (i % 2 == 0 ? 1 : -1) * 
            math.cos((x + i * 50) / 150));
        
        if (x == -50) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      
      canvas.drawPath(path, paint);
    }

    // Add some circular contours for variety
    for (int i = 0; i < 5; i++) {
      final centerX = (i % 2 == 0) ? size.width * 0.3 : size.width * 0.7;
      final centerY = 100.0 + (i * 80.0);
      
      for (int j = 1; j < 4; j++) {
        canvas.drawCircle(
          Offset(centerX, centerY),
          j * 30.0,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
