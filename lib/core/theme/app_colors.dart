import 'package:flutter/material.dart';

/// Bedbees App Color Palette
/// Premium travel app design system with glassmorphism
class AppColors {
  // Primary Brand Colors
  static const Color primaryTeal = Color(0xFF00C4B3);
  static const Color primaryOrange = Color(0xFFFF8C32);
  static const Color primaryYellow = Color(0xFFF9D162);
  static const Color primaryGrey = Color(0xFF777777);
  
  // Premium Blue Gradients (Main theme)
  static const Color gradientBlueStart = Color(0xFF0EA5E9);
  static const Color gradientBlueEnd = Color(0xFF1C3FAA);
  static const Color gradientTealStart = Color(0xFF00C4B3);
  static const Color gradientTealEnd = Color(0xFF0EA5E9);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF333333);
  static const Color mediumGrey = Color(0xFF777777);
  static const Color lightGrey = Color(0xFFCCCCCC);
  static const Color extraLightGrey = Color(0xFFF5F5F5);
  
  // Glassmorphism Colors (20-40% opacity)
  static Color glassWhite = Colors.white.withOpacity(0.25);
  static Color glassWhiteStrong = Colors.white.withOpacity(0.4);
  static Color glassBlack = Colors.black.withOpacity(0.2);
  static Color glassTeal = const Color(0xFF00C4B3).withOpacity(0.3);
  static Color glassBlue = const Color(0xFF0EA5E9).withOpacity(0.25);
  
  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1F2937);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientBlueStart, gradientBlueEnd],
  );
  
  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryTeal, gradientBlueStart],
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryTeal,
      Color(0xFF00C4B3),
      Color(0xFF0EA5E9),
    ],
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryOrange, Color(0xFFFF6B35)],
  );
  
  // Soft shadows for premium feel
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 30,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> strongShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 40,
      offset: const Offset(0, 12),
    ),
  ];
}
