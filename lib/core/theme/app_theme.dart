import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF2F2F2), // Light grey background
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF5C5C5C), // Mid-dark grey primary
        secondary: Color(0xFF8F8F8F), // Mid-light grey secondary
        surface: Colors.white,
        error: Color(0xFFD32F2F),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1C1C1C), // Very dark grey text
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C)),
        displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, color: const Color(0xFF1C1C1C)),
        titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xFF1C1C1C)),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF1C1C1C)),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF6B6B6B)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1C1C1C)),
        titleTextStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1C1C1C), letterSpacing: 1.2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5C5C5C),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF121212), // Very dark grey background
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFB3B3B3), // Light grey primary
        secondary: Color(0xFF7A7A7A), // Mid grey secondary
        surface: Color(0xFF1E1E1E), // Dark grey surface
        error: Color(0xFFEF5350),
        onPrimary: Color(0xFF121212),
        onSecondary: Color(0xFF121212),
        onSurface: Color(0xFFE0E0E0),
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFFE0E0E0)),
        displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, color: const Color(0xFFE0E0E0)),
        titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xFFE0E0E0)),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFFE0E0E0)),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF9E9E9E)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFE0E0E0)),
        titleTextStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFFE0E0E0), letterSpacing: 1.2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB3B3B3),
          foregroundColor: const Color(0xFF121212),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
