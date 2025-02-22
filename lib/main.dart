import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/pages/create_food_page.dart';
import 'package:diet_app/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: FoodPage(),
    );
  }
}

