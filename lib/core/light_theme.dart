import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white, // Text and icon colors
    elevation: 4,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.green,
    onPrimary: Colors.white,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  ),


  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    focusColor: Colors.green,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.green),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.green),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.green, width: 2),
    ),
    labelStyle: TextStyle(color: Colors.green),
    hintStyle: TextStyle(color: Colors.black54),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black26,
    elevation: 4,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),

  dividerTheme: DividerThemeData(
    color: Colors.green,
    thickness: 1.5,
  ),

  iconTheme: IconThemeData(color: Colors.green, size: 24),
  primaryIconTheme: IconThemeData(color: Colors.white, size: 24),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.green,
    contentTextStyle: TextStyle(color: Colors.white),
    actionTextColor: Colors.white,
  ),

  tabBarTheme: TabBarTheme(
    labelColor: Colors.green,
    unselectedLabelColor: Colors.black54,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.green, width: 2),
    ),
  ),
);
