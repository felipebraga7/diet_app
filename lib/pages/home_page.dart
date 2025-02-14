import 'package:diet_app/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';

import '../widgets/calendar_selector.dart';
import '../widgets/meal_list.dart';
import '../widgets/meal_summary.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CalendarSelector(),
                MealSummary(),
                MealList(),
              ]),
        ),
        bottomNavigationBar: BottomMenu(),
      ),
    );
  }
}
