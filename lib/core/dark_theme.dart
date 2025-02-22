import 'package:flutter/material.dart';

import 'app_color_dark_theme.dart';

final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme.light(
      primary: AppColorsDarkTheme.primary,
      onPrimary: AppColorsDarkTheme.onPrimary,
      surface: AppColorsDarkTheme.surface,
      secondary: AppColorsDarkTheme.secondary,
      onSecondary: AppColorsDarkTheme.onSecondary,
      inverseSurface: AppColorsDarkTheme.inverseSurface,
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        labelLarge: TextStyle(fontSize: 18, color: Colors.blueGrey),
        labelMedium: TextStyle(fontSize: 14, color: Colors.blueGrey),
        labelSmall: TextStyle(fontSize: 12, color: Colors.blueGrey),
        headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black26,
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        foregroundColor: Colors.red,
        backgroundColor: Colors.blueAccent,
      ),
    ));