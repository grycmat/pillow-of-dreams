import 'package:flutter/material.dart';

class AppTheme {
  static ColorScheme lightScheme = const ColorScheme(
    primary: Color(0xFFE91E63),
    // Vibrant Pink
    primaryContainer: Color(0xFFC2185B),
    secondary: Color(0xFF03A9F4),
    // Bright Blue
    secondaryContainer: Color(0xFF0288D1),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF3F3F3),
    // Light Grey
    error: Color(0xFFD32F2F),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    // Dark Text
    onBackground: Color(0xFF212121),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.light,
  );

  static ColorScheme darkScheme = const ColorScheme(
    primary: Color(0xFFBB86FC),
    // Purple
    primaryContainer: Color(0xFF3700B3),
    secondary: Color(0xFF03DAC6),
    // Teal
    secondaryContainer: Color(0xFF018786),
    surface: Color(0xFF121212),
    // Dark Surface
    background: Color(0xFF121212),
    // Dark Background
    error: Color(0xFFCF6679),
    onPrimary: Color(0xFF000000),
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFFFFFFFF),
    // Light Text
    onBackground: Color(0xFFFFFFFF),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme() {
    return ThemeData.from(
      colorScheme: lightScheme,
      useMaterial3: true,
      textTheme: const TextTheme().apply(fontFamily: 'Lato'),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.from(
      colorScheme: darkScheme,
      useMaterial3: true,
      textTheme: const TextTheme().apply(fontFamily: 'Lato'),
    );
  }
}
