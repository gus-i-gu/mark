import 'package:flutter/material.dart';

abstract final class MarkeiColors {
  static const cream = Color(0xfff6f1e8);
  static const surface = Color(0xfffffcf6);
  static const green = Color(0xff1f5f4b);
  static const lavender = Color(0xff8270c8);
  static const ink = Color(0xff1d2a24);
}

ThemeData markeiTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: MarkeiColors.green,
    primary: MarkeiColors.green,
    secondary: MarkeiColors.lavender,
    surface: MarkeiColors.surface,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: MarkeiColors.cream,
    cardTheme: const CardThemeData(
      color: MarkeiColors.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: MarkeiColors.surface,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: MarkeiColors.surface,
      selectedIconTheme: const IconThemeData(color: MarkeiColors.green),
      selectedLabelTextStyle: const TextStyle(
        color: MarkeiColors.green,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
