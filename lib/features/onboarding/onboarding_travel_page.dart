import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingTravelPage extends StatelessWidget {
  const OnboardingTravelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C4B3), // Exact teal
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
                        painter: _TravelIllustrationPainter(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Title
                    const Text(
                      'TRAVEL',
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
                      'Discover amazing places around the world. Book your next adventure with ease and create unforgettable memories.',
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
                            _buildDot(true),
                            const SizedBox(width: 8),
                            _buildDot(false),
                            const SizedBox(width: 8),
                            _buildDot(false),
                          ],
                        ),
                        // Next button
                        GestureDetector(
                          onTap: () => context.go('/onboarding/journey'),
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

class _TravelIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Yellow blob background
    paint.color = const Color(0xFFF9D162).withOpacity(0.3); // Exact yellow
    final path1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.1, size.width * 0.6, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width * 0.7, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.7, size.width * 0.4, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.2, size.height * 0.5, size.width * 0.2, size.height * 0.3);
    canvas.drawPath(path1, paint);

    // Turquoise suitcase
    paint.color = const Color(0xFF00C4B3);
    final suitcaseRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.35, size.width * 0.4, size.height * 0.45),
      const Radius.circular(12),
    );
    canvas.drawRRect(suitcaseRect, paint);

    // Suitcase handle
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 6;
    paint.color = const Color(0xFF00A89A);
    final handlePath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.35)
      ..quadraticBezierTo(
        size.width * 0.45, size.height * 0.25,
        size.width * 0.55, size.height * 0.35,
      );
    canvas.drawPath(handlePath, paint);

    paint.style = PaintingStyle.fill;

    // Stickers on suitcase
    paint.color = const Color(0xFFFF8C32); // Orange sticker
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.5), 12, paint);
    
    paint.color = const Color(0xFFF9D162); // Yellow sticker
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.5, size.height * 0.55, 30, 20),
        const Radius.circular(4),
      ),
      paint,
    );

    // Orange backpack
    paint.color = const Color(0xFFFF8C32); // Exact orange
    final backpackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.65, size.height * 0.5, size.width * 0.25, size.height * 0.3),
      const Radius.circular(10),
    );
    canvas.drawRRect(backpackRect, paint);

    // Backpack pocket
    paint.color = const Color(0xFFFF8255);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.68, size.height * 0.55, size.width * 0.19, size.height * 0.15),
        const Radius.circular(6),
      ),
      paint,
    );

    // Backpack straps
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = const Color(0xFFE05A2C);
    canvas.drawLine(
      Offset(size.width * 0.68, size.height * 0.5),
      Offset(size.width * 0.68, size.height * 0.45),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.87, size.height * 0.5),
      Offset(size.width * 0.87, size.height * 0.45),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
