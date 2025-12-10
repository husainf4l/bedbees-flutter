import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingTravelerPage extends StatelessWidget {
  const OnboardingTravelerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C4B3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
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
                child: Column(
                  children: [
                    // Illustration
                    SizedBox(
                      height: 280,
                      child: CustomPaint(
                        size: const Size(280, 280),
                        painter: _TravelerIllustrationPainter(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Title
                    const Text(
                      'TRAVELER',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFF8C32), // Exact orange
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Subtitle
                    const Text(
                      'Explore the world like never before. Connect with local experiences and make every trip memorable.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF777777), // Exact grey
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dots
                        Row(
                          children: [
                            _buildDot(false),
                            const SizedBox(width: 8),
                            _buildDot(false),
                            const SizedBox(width: 8),
                            _buildDot(true),
                          ],
                        ),
                        // Get Started button
                        GestureDetector(
                          onTap: () => context.go('/bedbees/login'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8C32), // Exact orange
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF8C32).withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF8C32) : const Color(0xFFE0E0E0), // Orange dot
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _TravelerIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Yellow blob background
    paint.color = const Color(0xFFF9D162).withOpacity(0.3); // Exact yellow
    final path1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.35)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.2, size.width * 0.6, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.4, size.width * 0.75, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.7, size.width * 0.35, size.height * 0.65)
      ..quadraticBezierTo(size.width * 0.15, size.height * 0.5, size.width * 0.2, size.height * 0.35);
    canvas.drawPath(path1, paint);

    // Teal hiking backpack
    paint.color = const Color(0xFF00C4B3);
    final backpackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.35, size.width * 0.35, size.height * 0.4),
      const Radius.circular(12),
    );
    canvas.drawRRect(backpackRect, paint);

    // Backpack top flap
    paint.color = const Color(0xFF00A89A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.3, size.height * 0.3, size.width * 0.35, size.height * 0.08),
        const Radius.circular(8),
      ),
      paint,
    );

    // Backpack straps
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 6;
    paint.color = const Color(0xFF008E82);
    canvas.drawLine(
      Offset(size.width * 0.33, size.height * 0.35),
      Offset(size.width * 0.33, size.height * 0.25),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.62, size.height * 0.35),
      Offset(size.width * 0.62, size.height * 0.25),
      paint,
    );

    paint.style = PaintingStyle.fill;

    // Backpack pocket
    paint.color = const Color(0xFF00D9C6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.35, size.height * 0.45, size.width * 0.25, size.height * 0.2),
        const Radius.circular(8),
      ),
      paint,
    );

    // Orange sleeping roll
    paint.color = const Color(0xFFFF8C32); // Exact orange
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.15, size.height * 0.5, size.width * 0.15, size.height * 0.3),
        const Radius.circular(30),
      ),
      paint,
    );

    // Roll straps
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    paint.color = const Color(0xFFE05A2C);
    canvas.drawLine(
      Offset(size.width * 0.15, size.height * 0.58),
      Offset(size.width * 0.3, size.height * 0.58),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.15, size.height * 0.68),
      Offset(size.width * 0.3, size.height * 0.68),
      paint,
    );

    paint.style = PaintingStyle.fill;

    // Hiking boots
    paint.color = const Color(0xFF8B4513);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.65, size.height * 0.6, size.width * 0.12, size.height * 0.15),
        const Radius.circular(6),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.78, size.height * 0.6, size.width * 0.12, size.height * 0.15),
        const Radius.circular(6),
      ),
      paint,
    );

    // Boot soles
    paint.color = const Color(0xFF654321);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.64, size.height * 0.74, size.width * 0.14, size.height * 0.04),
        const Radius.circular(3),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.77, size.height * 0.74, size.width * 0.14, size.height * 0.04),
        const Radius.circular(3),
      ),
      paint,
    );

    // Yellow beanie
    paint.color = const Color(0xFFFFD93D);
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.68, size.height * 0.35, size.width * 0.2, size.height * 0.15),
      paint,
    );

    // Beanie pom-pom
    paint.color = const Color(0xFFFFCA1F);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.33), 8, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
