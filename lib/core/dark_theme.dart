import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.teal,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
  ),
);
