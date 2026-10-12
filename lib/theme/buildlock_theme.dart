import 'package:flutter/material.dart';

class BuildLockTheme {
  // High-Contrast Palette
  static const navy = Color(0xFF0F172A); // Dark Slate #0F172A
  static const navyLight = Color(0xFF1E293B);
  static const orange = Color(0xFFF59E0B); // Rapido Safety Amber #F59E0B
  static const orangeSoft = Color(0xFFFEF3C7);
  static const bg = Color(0xFFF8FAFC);
  static const card = Colors.white;
  static const border = Color(0xFFE2E8F0);

  static const green = Color(0xFF10B981); // Emerald #10B981
  static const greenSoft = Color(0xFFECFDF5);
  static const amber = Color(0xFFF59E0B);
  static const red = Color(0xFFEF4444);
  static const redSoft = Color(0xFFFEF2F2);

  // AI Gradient Surface Accent (#6366F1 to #8B5CF6)
  static const aiStart = Color(0xFF6366F1);
  static const aiEnd = Color(0xFF8B5CF6);
  static const aiGradient = LinearGradient(
    colors: [aiStart, aiEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: orange,
          primary: orange,
          secondary: navy,
          surface: card,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: border, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: orange, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: orange,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(54),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      );
}
