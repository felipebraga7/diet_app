import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/widgets/meal_detail.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/update_meal_page.dart';

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
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: c.mealList.length,
                itemBuilder: (ctx, i) {
                  final meal = c.mealList[i];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => UpdateMealPage(meal: meal));
                    },
                    child: MealDetail(meal),
                  );
                },
                separatorBuilder: (ctx, _) => SimpleDivider(
                  padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
