import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bedbees_colors.dart';

/// 🎨 BEDBEES MATERIAL THEME
/// Official theme configuration for the travel super-app
class BedbeesTheme {
  /// Light theme with official Bedbees colors
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // ============================================
      // COLOR SCHEME
      // ============================================
      colorScheme: ColorScheme.fromSeed(
        seedColor: BedbeesColors.primaryBlue,
        primary: BedbeesColors.primaryBlue,
        secondary: BedbeesColors.coral,
        tertiary: BedbeesColors.sunshineYellow,
        surface: BedbeesColors.screenBackground,
        background: BedbeesColors.screenBackground,
        error: BedbeesColors.dangerRed,
        brightness: Brightness.light,
      ),
      
      // ============================================
      // SCAFFOLD
      // ============================================
      scaffoldBackgroundColor: BedbeesColors.screenBackground,
      
      // ============================================
      // APP BAR
      // ============================================
      appBarTheme: AppBarTheme(
        backgroundColor: BedbeesColors.screenBackground,
        foregroundColor: BedbeesColors.darkText,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BedbeesColors.darkText,
        ),
      ),
      
      // ============================================
      // CARD
      // ============================================
      cardTheme: CardThemeData(
        color: BedbeesColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(0),
        shadowColor: BedbeesColors.darkText.withOpacity(0.08),
      ),
      
      // ============================================
      // ELEVATED BUTTON
      // ============================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BedbeesColors.primaryBlue,
          foregroundColor: BedbeesColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          shadowColor: BedbeesColors.primaryBlue.withOpacity(0.3),
        ),
      ),
      
      // ============================================
      // TEXT BUTTON
      // ============================================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: BedbeesColors.primaryBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // ============================================
      // OUTLINED BUTTON
      // ============================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: BedbeesColors.primaryBlue,
          side: const BorderSide(color: BedbeesColors.primaryBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // ============================================
      // INPUT DECORATION
      // ============================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BedbeesColors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: BedbeesColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: BedbeesColors.dangerRed, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: BedbeesColors.greyText,
        ),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: BedbeesColors.greyText,
        ),
      ),
      
      // ============================================
      // ICON
      // ============================================
      iconTheme: const IconThemeData(
        color: BedbeesColors.darkText,
        size: 24,
      ),
      
      // ============================================
      // BOTTOM NAVIGATION BAR
      // ============================================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: BedbeesColors.white,
        selectedItemColor: BedbeesColors.primaryBlue,
        unselectedItemColor: BedbeesColors.greyText,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // ============================================
      // CHIP
      // ============================================
      chipTheme: ChipThemeData(
        backgroundColor: BedbeesColors.cardBackground,
        selectedColor: BedbeesColors.primaryBlue,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // ============================================
      // DIALOG
      // ============================================
      dialogTheme: DialogThemeData(
        backgroundColor: BedbeesColors.white,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BedbeesColors.darkText,
        ),
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: BedbeesColors.darkText,
          height: 1.5,
        ),
      ),
      
      // ============================================
      // TYPOGRAPHY
      // ============================================
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: BedbeesColors.darkText,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: BedbeesColors.darkText,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: BedbeesColors.darkText,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: BedbeesColors.darkText,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BedbeesColors.darkText,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: BedbeesColors.darkText,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: BedbeesColors.darkText,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: BedbeesColors.darkText,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: BedbeesColors.greyText,
        ),
      ),
      
      // ============================================
      // DIVIDER
      // ============================================
      dividerTheme: const DividerThemeData(
        color: BedbeesColors.lightGrey,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
