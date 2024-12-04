import 'package:flutter/material.dart';

import 'color.dart';

abstract class ThemeConstans {
  ThemeConstans._();

  // Light Theme
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.white,
    // Darkest color for primary (buttons, AppBar, etc.)
    onPrimary: Colors.white,
    // Light text/icons on primary elements
    secondary: Colors.white,
    // Lighter accent color for secondary elements
    onSecondary: Colors.white,
    // White text/icons on secondary elements
    error: Colors.redAccent,
    onError: Colors.white,
    surface: ColorConstants.ligthTheme_color_1,
    // Mid-tone color for surface elements
    onSurface: Colors.black,
    // Dark text for surface elements
    brightness: Brightness.light, // Light theme
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Colors.white,
    // Lightest color for primary in dark theme (buttons, etc.)
    onPrimary: Colors.black,
    // Dark text/icons on primary elements
    secondary: Colors.white,
    // Medium-tone accent color for secondary elements
    onSecondary: Colors.white,
    // Light text/icons on secondary elements
    error: Colors.redAccent,
    onError: Colors.white,
    surface: ColorConstants.darkTheme_color_1,
    // Medium-tone surface color
    onSurface: ColorConstants.darkTheme_color_1,
    secondaryContainer: Colors.white,
    secondaryFixed: Colors.white,
    onSecondaryContainer: Colors.white,
    // Dark text for surface elements
    brightness: Brightness.dark, // Dark theme
  );

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
        secondaryHeaderColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          // Tüm büyük metinler
          bodyMedium: TextStyle(color: Colors.white),
          // Orta boyutlu metinler
          bodySmall: TextStyle(color: Colors.white),
          // Küçük metinler
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        ),
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        highlightColor: Colors.transparent,
        buttonTheme: ButtonThemeData(colorScheme: colorScheme));
  }
}