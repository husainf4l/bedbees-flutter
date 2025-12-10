import 'package:flutter/material.dart';

/// 🎨 BEDBEES OFFICIAL COLOR PALETTE
/// Complete brand color system for the travel super-app
class BedbeesColors {
  // ============================================
  // PRIMARY BRAND COLOR - Bedbees Blue
  // ============================================
  /// Trust, Modern Travel
  /// Use for: primary buttons, highlights, navigation, selection states
  static const Color primaryBlue = Color(0xFF0EA5E9);
  static const Color primaryBlueDark = Color(0xFF0284C7);
  static const Color primaryBlueLight = Color(0xFF38BDF8);
  
  // ============================================
  // SECONDARY ACCENT - Bedbees Coral/Warm Orange
  // ============================================
  /// Energy, Adventure
  /// Use for: CTAs, price tags, icons, ratings, active states
  static const Color coral = Color(0xFFFF6F4E);
  static const Color coralDark = Color(0xFFE64A2E);
  static const Color coralLight = Color(0xFFFF8F73);
  
  // ============================================
  // TRAVEL HIGHLIGHT - Sunshine Yellow
  // ============================================
  /// Joy, Vacation Energy
  /// Use for: decorative accents, illustrations, badges
  static const Color sunshineYellow = Color(0xFFF9C94C);
  static const Color sunshineYellowDark = Color(0xFFE5B43C);
  static const Color sunshineYellowLight = Color(0xFFFBD76C);
  
  // ============================================
  // NEUTRAL PALETTE
  // ============================================
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color greyText = Color(0xFF6B6B6B);
  static const Color cardBackground = Color(0xFFF5F7F9);
  static const Color screenBackground = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFE5E7EB);
  static const Color borderGrey = Color(0xFFD1D5DB);
  
  // ============================================
  // SUPPORT COLORS
  // ============================================
  static const Color successGreen = Color(0xFF2ECC71);
  static const Color dangerRed = Color(0xFFE03131);
  static const Color warningOrange = Color(0xFFFFA500);
  static const Color infoBlue = Color(0xFF3B82F6);
  
  // ============================================
  // GRADIENTS
  // ============================================
  /// Primary Blue Gradient - For hero sections and backgrounds
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0EA5E9),
      Color(0xFF1C3FAA),
    ],
  );
  
  /// Soft Blue Gradient - For lighter sections
  static const LinearGradient softBlueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0EA5E9),
      Color(0xFF38BDF8),
    ],
  );
  
  /// Coral Gradient - For CTAs and highlights
  static const LinearGradient coralGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6F4E),
      Color(0xFFFF8F73),
    ],
  );
  
  /// Sunset Gradient - Blue to Coral
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0EA5E9),
      Color(0xFFFF6F4E),
    ],
  );
  
  /// Travel Card Overlay - For image overlays
  static LinearGradient get travelCardOverlay => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      darkText.withOpacity(0.7),
    ],
  );
  
  // ============================================
  // SHADOWS
  // ============================================
  /// Soft shadow for cards
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: darkText.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Medium shadow for elevated elements
  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: darkText.withOpacity(0.12),
      blurRadius: 30,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Strong shadow for floating buttons
  static List<BoxShadow> get strongShadow => [
    BoxShadow(
      color: darkText.withOpacity(0.15),
      blurRadius: 40,
      offset: const Offset(0, 12),
    ),
  ];
  
  /// Colored shadow for primary buttons
  static List<BoxShadow> get primaryButtonShadow => [
    BoxShadow(
      color: primaryBlue.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Colored shadow for coral buttons
  static List<BoxShadow> get coralButtonShadow => [
    BoxShadow(
      color: coral.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}
