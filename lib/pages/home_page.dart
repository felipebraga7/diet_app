import 'package:diet_app/controller/meal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../widgets/add_edit_meal_dialog.dart';
import '../widgets/calendar_selector.dart';
import '../widgets/meal_list.dart';
import '../widgets/meal_summary.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 10, children: [
            CalendarSelector(),
            MealSummary(),
            MealList(),
          ]),
        ),
      ),
    );
  }
}
