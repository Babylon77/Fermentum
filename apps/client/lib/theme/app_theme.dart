import 'package:flutter/material.dart';

ThemeData buildFermentumTheme() {
  const canvas = Color(0xFF070B11);
  const shell = Color(0xFF0B1220);
  const panel = Color(0xFF131D2E);
  const border = Color(0xFF2B4263);
  const focus = Color(0xFF37D7FF);
  const textPrimary = Color(0xFFE6F0FF);
  const textSecondary = Color(0xFF9CB3CC);

  final base = ThemeData.dark(useMaterial3: true);

  return base.copyWith(
    scaffoldBackgroundColor: canvas,
    colorScheme: const ColorScheme.dark(
      primary: focus,
      secondary: Color(0xFFFFB84D),
      surface: shell,
      error: Color(0xFFFF5D73),
    ),
    textTheme: base.textTheme.copyWith(
      displaySmall: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: 0.5,
      ),
      headlineSmall: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        height: 1.5,
        color: textSecondary,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        height: 1.5,
        color: textSecondary,
      ),
      labelMedium: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: focus,
        letterSpacing: 1.2,
      ),
    ),
    cardTheme: const CardThemeData(
      color: panel,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: border),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF0D1624),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: focus, width: 2),
      ),
    ),
  );
}

