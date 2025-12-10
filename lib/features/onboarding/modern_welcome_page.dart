import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModernWelcomePage extends StatelessWidget {
  const ModernWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
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
                      ),
                    ),
                    child: CustomPaint(
                      painter: TopographyPainter(),
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
                    painter: WavePainter(),
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
                        // Title
                        const Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Subtitle lines
                        const Text(
                          'Experience seamless travel booking\nwith Bedbees. Your journey begins\nhere with comfort and ease.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                            height: 1.6,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const Spacer(),
                        // Continue button
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => context.go('/modern-signin'),
                            child: Container(
                              width: 140,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0ea5e9).withValues(alpha: 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0ea5e9),
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0ea5e9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
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

class TopographyPainter extends CustomPainter {
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
