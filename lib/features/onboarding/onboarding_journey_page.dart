import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingJourneyPage extends StatelessWidget {
  const OnboardingJourneyPage({super.key});

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
                        painter: _JourneyIllustrationPainter(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Title
                    const Text(
                      'JOURNEY',
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
                      'Pack your bags and get ready for new experiences. Every journey starts with a single step towards adventure.',
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
                            _buildDot(true),
                            const SizedBox(width: 8),
                            _buildDot(false),
                          ],
                        ),
                        // Next button
                        GestureDetector(
                          onTap: () => context.go('/onboarding/traveler'),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8C32), // Exact orange
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF8C32).withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 28,
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

class _JourneyIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Yellow blob background
    paint.color = const Color(0xFFF9D162).withOpacity(0.3); // Exact yellow
    final path1 = Path()
      ..moveTo(size.width * 0.15, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.15, size.width * 0.55, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.35, size.width * 0.8, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.65, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.55, size.width * 0.15, size.height * 0.25);
    canvas.drawPath(path1, paint);

    // Teal beach bag
    paint.color = const Color(0xFF00C4B3);
    final bagPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.4)
      ..lineTo(size.width * 0.55, size.height * 0.4)
      ..lineTo(size.width * 0.5, size.height * 0.7)
      ..lineTo(size.width * 0.3, size.height * 0.7)
      ..close();
    canvas.drawPath(bagPath, paint);

    // Bag handles
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    paint.color = const Color(0xFF00A89A);
    final handle1 = Path()
      ..moveTo(size.width * 0.3, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.32, size.height * 0.32, size.width * 0.35, size.height * 0.4);
    canvas.drawPath(handle1, paint);
    
    final handle2 = Path()
      ..moveTo(size.width * 0.45, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.48, size.height * 0.32, size.width * 0.5, size.height * 0.4);
    canvas.drawPath(handle2, paint);

    paint.style = PaintingStyle.fill;

    // Orange hat
    paint.color = const Color(0xFFFF8C32); // Exact orange
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.55, size.height * 0.35, size.width * 0.35, size.height * 0.12),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.6, size.height * 0.38, size.width * 0.25, size.height * 0.15),
        const Radius.circular(8),
      ),
      paint,
    );

    // Sunscreen bottle
    paint.color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.15, size.height * 0.55, size.width * 0.12, size.height * 0.25),
        const Radius.circular(6),
      ),
      paint,
    );
    
    paint.color = const Color(0xFF00C4B3);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.15, size.height * 0.55, size.width * 0.12, size.height * 0.08),
        const Radius.circular(6),
      ),
      paint,
    );

    // Yellow shorts
    paint.color = const Color(0xFFF9D162); // Exact yellow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.65, size.height * 0.55, size.width * 0.25, size.height * 0.22),
        const Radius.circular(10),
      ),
      paint,
    );

    // Shorts details
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = const Color(0xFFFFCA1F);
    canvas.drawLine(
      Offset(size.width * 0.775, size.height * 0.55),
      Offset(size.width * 0.775, size.height * 0.77),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
