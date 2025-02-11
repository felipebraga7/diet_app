import 'package:diet_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/food.dart';
import 'pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FoodAdapter());
  await Hive.openBox<Food>('foods');
  await Hive.openBox<Food>('meals');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      home: MyHomePage(),
    );
  }
}

