import 'package:diet_app/controller/bottom_navigation_bar_controller.dart';
import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/widgets/meal_detail.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealList extends StatelessWidget {
  const MealList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MealController>(
      builder: (c) {
        return Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
              child: ListView.separated(
                controller: Get.put(BottomNavigationBarController()).scrollController,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (ctx, i) => MealDetail(c.mealList[i]),
                  separatorBuilder: (ctx, _) => SimpleDivider(
                        padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
                      ),
                  itemCount: c.mealList.length),
            ),
          ),
        );
      },
    );
  }
}
