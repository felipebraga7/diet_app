import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/main.dart';
import 'package:diet_app/model/meal.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/food.dart';
import 'add_edit_meal_dialog.dart';

class MealDetail extends StatelessWidget {
  final Meal meal;

  const MealDetail(this.meal, {super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 50,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(meal.mealCategory.icon, size: 44, color: meal.mealCategory.color),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(meal.dateTime),
                        style: textTheme.labelSmall,
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          meal.mealCategory.name,
                          style: textTheme.headlineMedium,
                        ),
                        Text(
                          '${meal.getTotalCalories().toStringAsFixed(0)}/${meal.calGoal.toStringAsFixed(0)} kcal',
                          style: textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 8,
                      child: LinearProgressIndicator(
                        value: meal.calGoal == 0 ? 0 : (meal.getTotalCalories() / meal.calGoal),
                        backgroundColor: colorScheme.secondary,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16,
            ),
            addButton(context, meal),
          ],
        ),
      ),
    );
  }

  Widget addButton(BuildContext context, Meal meal) {
    var colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AddEditMealDialog(
              meal: meal,
            );
          },
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: colorScheme.inverseSurface.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
