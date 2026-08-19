import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for all colors, text styles and theming.
/// Chosen palette gives a "print newspaper" feel: ink black, warm paper
/// background, and a single accent (deep red) used sparingly like a
/// masthead accent color.
class AppColors {
  static const Color ink = Color(0xFF1A1A1A);
  static const Color paper = Color(0xFFFBF7F0);
  static const Color paperDark = Color(0xFFF1EAD9);
  static const Color accent = Color(0xFFA6192E); // classic masthead red
  static const Color accentLight = Color(0xFFF6E4E7);
  static const Color subtitle = Color(0xFF6B6B6B);
  static const Color divider = Color(0xFFDDD5C4);
  static const Color success = Color(0xFF2E7D32);
  static const Color cardShadow = Color(0x14000000);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.paper,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.ink,
        secondary: AppColors.accent,
        surface: AppColors.paper,
      ),
      textTheme: GoogleFonts.sourceSerif4TextTheme(base.textTheme).copyWith(
        // Headlines use a serif "newspaper" font
        displayLarge: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w800, color: AppColors.ink),
        headlineLarge: GoogleFonts.playfairDisplay(
            fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.ink),
        headlineMedium: GoogleFonts.playfairDisplay(
            fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink),
        headlineSmall: GoogleFonts.playfairDisplay(
            fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.ink),
        bodyLarge: GoogleFonts.sourceSerif4(
            fontSize: 15, color: AppColors.ink, height: 1.4),
        bodyMedium: GoogleFonts.sourceSerif4(
            fontSize: 13.5, color: AppColors.subtitle, height: 1.4),
        labelLarge: GoogleFonts.inter(
            fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.paper,
        elevation: 0,
        foregroundColor: AppColors.ink,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.paper,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.ink, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.2),
        ),
      ),
      useMaterial3: true,
    );
  }
}
