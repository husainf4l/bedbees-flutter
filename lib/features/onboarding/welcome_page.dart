import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import '../../core/theme/app_theme.dart';

/// Welcome/Intro Screen - Playful Pastel Design
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Pastel Background Shapes
          Positioned(
            top: -100,
            right: -50,
            child: _PastelCircle(
              size: 250,
              color: AppTheme.pastelYellow.withOpacity(0.3),
            ),
          ),
          Positioned(
            top: 100,
            left: -80,
            child: _PastelCircle(
              size: 200,
              color: AppTheme.secondaryColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -30,
            child: _PastelCircle(
              size: 180,
              color: AppTheme.accentColor.withOpacity(0.25),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -40,
            child: _PastelCircle(
              size: 150,
              color: AppTheme.pastelLavender.withOpacity(0.3),
            ),
          ),
          
          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo/Brand
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.travel_explore,
                          color: AppTheme.primaryColor,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Bedbees',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Travel Illustration (Emoji-based for now)
                  Container(
                    width: size.width * 0.8,
                    height: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background gradient
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppTheme.pastelBlue.withOpacity(0.1),
                                AppTheme.pastelYellow.withOpacity(0.1),
                                AppTheme.secondaryColor.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                        
                        // Travel Icons/Emojis
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Hot air balloon
                            Text(
                              '🎈',
                              style: TextStyle(fontSize: 80),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('✈️', style: TextStyle(fontSize: 40)),
                                SizedBox(width: 20),
                                Text('🌍', style: TextStyle(fontSize: 50)),
                                SizedBox(width: 20),
                                Text('🧳', style: TextStyle(fontSize: 40)),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('🏨', style: TextStyle(fontSize: 35)),
                                SizedBox(width: 15),
                                Text('🚕', style: TextStyle(fontSize: 35)),
                                SizedBox(width: 15),
                                Text('🎫', style: TextStyle(fontSize: 35)),
                              ],
                            ),
                          ],
                        ),
                        
                        // Floating decorative elements
                        Positioned(
                          top: 30,
                          left: 30,
                          child: _FloatingElement(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.pastelYellow.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('☁️', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 40,
                          child: _FloatingElement(
                            delay: 1.0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('⭐', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 40,
                          child: _FloatingElement(
                            delay: 0.5,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('🎒', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Title
                  Text(
                    'Travel The World\nWith Us',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Text(
                    'Find the best deals on hotels, tours, cars,\ntaxis, shared trips and destinations\naround the world.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // "Let's Go!" Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => context.go('/auth/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.buttonDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Let\'s Go!',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Bedbees Onboarding Button (NEW)
                  TextButton(
                    onPressed: () => context.go('/onboarding/travel'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C4B3).withOpacity(0.1),
                        border: Border.all(
                          color: const Color(0xFF00C4B3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.airplane_ticket,
                            color: Color(0xFFFF6B35),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '🎨 NEW Bedbees Onboarding',
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Modern UI Showcase Button
                  TextButton(
                    onPressed: () => context.push('/modern-showcase'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF0ea5e9).withOpacity(0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone_iphone,
                            color: Color(0xFF0ea5e9),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'View Modern UI Design',
                            style: TextStyle(
                              color: Color(0xFF0ea5e9),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Pastel Circle Widget
class _PastelCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _PastelCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0),
          ],
        ),
      ),
    );
  }
}

// Floating Animation Widget
class _FloatingElement extends StatefulWidget {
  final Widget child;
  final double delay;

  const _FloatingElement({required this.child, this.delay = 0});

  @override
  State<_FloatingElement> createState() => _FloatingElementState();
}

class _FloatingElementState extends State<_FloatingElement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    if (widget.delay > 0) {
      Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
        if (mounted) _controller.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_controller.value * 2 * math.pi) * 10),
          child: widget.child,
        );
      },
    );
  }
}
