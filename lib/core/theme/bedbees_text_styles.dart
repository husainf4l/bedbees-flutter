import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bedbees_colors.dart';

/// 🎯 BEDBEES TYPOGRAPHY SYSTEM
/// Modern, clean typography using Inter/Poppins style
class BedbeesTextStyles {
  // ============================================
  // DISPLAY STYLES - Hero Headlines
  // ============================================
  
  /// Display Large - 40px, Bold
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: BedbeesColors.darkText,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  /// Display Medium - 32px, Bold
  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: BedbeesColors.darkText,
    height: 1.25,
    letterSpacing: -0.3,
  );
  
  /// Display Small - 28px, SemiBold
  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: BedbeesColors.darkText,
    height: 1.3,
  );
  
  // ============================================
  // HEADING STYLES
  // ============================================
  
  /// Heading 1 - 24px, Bold
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: BedbeesColors.darkText,
    height: 1.3,
  );
  
  /// Heading 2 - 20px, SemiBold
  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: BedbeesColors.darkText,
    height: 1.4,
  );
  
  /// Heading 3 - 18px, SemiBold
  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: BedbeesColors.darkText,
    height: 1.4,
  );
  
  /// Heading 4 - 16px, Medium
  static TextStyle h4 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: BedbeesColors.darkText,
    height: 1.5,
  );
  
  // ============================================
  // BODY STYLES
  // ============================================
  
  /// Body Large - 16px, Regular
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: BedbeesColors.darkText,
    height: 1.6,
  );
  
  /// Body Medium - 14px, Regular
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: BedbeesColors.darkText,
    height: 1.5,
  );
  
  /// Body Small - 12px, Regular
  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: BedbeesColors.greyText,
    height: 1.5,
  );
  
  // ============================================
  // SPECIALIZED STYLES
  // ============================================
  
  /// Button Text - 16px, SemiBold
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: BedbeesColors.white,
    height: 1.2,
    letterSpacing: 0.3,
  );
  
  /// Button Small - 14px, SemiBold
  static TextStyle buttonSmall = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: BedbeesColors.white,
    height: 1.2,
    letterSpacing: 0.2,
  );
  
  /// Caption - 12px, Medium
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: BedbeesColors.greyText,
    height: 1.4,
  );
  
  /// Overline - 10px, SemiBold, Uppercase
  static TextStyle overline = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: BedbeesColors.greyText,
    height: 1.6,
    letterSpacing: 1.5,
  );
  
  /// Price - 24px, Bold
  static TextStyle price = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: BedbeesColors.coral,
    height: 1.2,
  );
  
  /// Price Small - 18px, Bold
  static TextStyle priceSmall = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: BedbeesColors.coral,
    height: 1.2,
  );
  
  /// Label - 14px, Medium
  static TextStyle label = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: BedbeesColors.darkText,
    height: 1.4,
  );
  
  /// Link - 14px, Medium, Blue
  static TextStyle link = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: BedbeesColors.primaryBlue,
    height: 1.5,
    decoration: TextDecoration.none,
  );
  
  /// Link Coral - 14px, Medium, Coral
  static TextStyle linkCoral = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: BedbeesColors.coral,
    height: 1.5,
    decoration: TextDecoration.none,
  );
  
  // ============================================
  // HELPER METHODS
  // ============================================
  
  /// Apply white color to any text style
  static TextStyle white(TextStyle style) => style.copyWith(
    color: BedbeesColors.white,
  );
  
  /// Apply grey color to any text style
  static TextStyle grey(TextStyle style) => style.copyWith(
    color: BedbeesColors.greyText,
  );
  
  /// Apply blue color to any text style
  static TextStyle blue(TextStyle style) => style.copyWith(
    color: BedbeesColors.primaryBlue,
  );
  
  /// Apply coral color to any text style
  static TextStyle coral(TextStyle style) => style.copyWith(
    color: BedbeesColors.coral,
  );
  
  /// Apply yellow color to any text style
  static TextStyle yellow(TextStyle style) => style.copyWith(
    color: BedbeesColors.sunshineYellow,
  );
}
