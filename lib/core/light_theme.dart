import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[100],
  colorScheme: ColorScheme.light(
    primary: Colors.blueAccent,
    onPrimary: Colors.white,
    surface: Colors.white,
    secondary: Colors.grey[300]!,
    onSecondary: Colors.blueGrey,
    inverseSurface: Colors.black,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: TextStyle(fontSize: 14, color: Colors.blueGrey),
    labelSmall: TextStyle(fontSize: 12, color: Colors.blueGrey),
    headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black26,
    elevation: 8,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

);
