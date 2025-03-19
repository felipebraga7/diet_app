import 'package:flutter/material.dart';

import 'app_color_light_theme.dart';

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme.light(
      primary: AppColorsLightTheme.primary,
      onPrimary: AppColorsLightTheme.onPrimary,
      surface: AppColorsLightTheme.surface,
      secondary: AppColorsLightTheme.secondary,
      onSecondary: AppColorsLightTheme.onSecondary,
      inverseSurface: AppColorsLightTheme.inverseSurface,
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface),
        titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface),
        bodyLarge: TextStyle(fontSize: 26, color: AppColorsLightTheme.inverseSurface),
        bodyMedium: TextStyle(fontSize: 22, color: AppColorsLightTheme.inverseSurface),
        bodySmall: TextStyle(fontSize: 18, color: AppColorsLightTheme.inverseSurface),
        labelLarge: TextStyle(fontSize: 18, color: AppColorsLightTheme.onSecondary),
        labelMedium: TextStyle(fontSize: 14, color: AppColorsLightTheme.onSecondary),
        labelSmall: TextStyle(fontSize: 12, color: AppColorsLightTheme.onSecondary),
        headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface),
        headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface)),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 18, color: AppColorsLightTheme.inverseSurface)
    ),
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
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColorsLightTheme.surface,
      elevation: 24.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface),
      contentTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColorsLightTheme.inverseSurface),
    ),);
