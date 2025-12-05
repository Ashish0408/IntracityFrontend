import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// User-facing theme for bus booking application
/// Matches Vande Fly design with orange and purple colors
class UsersTheme {
  // Color palette (Vande Fly inspired)
  static const Color primaryColor = Color(0xFFFF9800); // Orange
  static const Color secondaryColor = Color(0xFF7B2CBF); // Purple
  static const Color accentColor = Color(0xFFFFC107); // Yellow
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color warningColor = Color(0xFFFFA726); // Light orange
  static const Color errorColor = Color(0xFFEF5350); // Red

  static const Color bgColorLight = Color(0xFFFAF8F3); // Cream/beige
  static const Color bgColorDark = Color(0xFF0D1B2A); // Dark navy
  static const Color cardColorLight = Color(0xFFFFFFFF); // White
  static const Color cardColorDark = Color(0xFF1A2332); // Dark slate

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bgColorLight,
      cardColor: cardColorLight,
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: Color(0xFF0D1B2A)),
          displayMedium: TextStyle(color: Color(0xFF0D1B2A)),
          displaySmall: TextStyle(color: Color(0xFF0D1B2A)),
          headlineMedium: TextStyle(color: Color(0xFF0D1B2A)),
          headlineSmall: TextStyle(color: Color(0xFF0D1B2A)),
          titleLarge: TextStyle(color: Color(0xFF0D1B2A)),
          titleMedium: TextStyle(color: Color(0xFF0D1B2A)),
          titleSmall: TextStyle(color: Color(0xFF0D1B2A)),
          bodyLarge: TextStyle(color: Color(0xFF0D1B2A)),
          bodyMedium: TextStyle(color: Color(0xFF0D1B2A)),
          bodySmall: TextStyle(color: Color(0xFF666666)),
          labelLarge: TextStyle(color: Color(0xFF0D1B2A)),
          labelMedium: TextStyle(color: Color(0xFF0D1B2A)),
          labelSmall: TextStyle(color: Color(0xFF666666)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColorLight,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: accentColor,
      scaffoldBackgroundColor: bgColorDark,
      cardColor: cardColorDark,
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Color(0xFFAAAAAA)),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Color(0xFFAAAAAA)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cardColorDark,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColorDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColorDark,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
