import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/pages/base_page.dart';
import 'package:diet_app/service/food_group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'service/food_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FoodService().initialize();
  await FoodGroupService().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      title: 'Diet App',
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      home: BasePage(),
    );
  }
}

