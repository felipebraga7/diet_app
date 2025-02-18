import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/meal.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChooseMealBottomDialog extends StatelessWidget {
  const ChooseMealBottomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Container(
      height: Get.height / 2,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Text(
            'Escolha uma refeição',
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Expanded(
            child: GetBuilder<MealController>(
                init: MealController(),
                builder: (c) {
                  return ListView.separated(
                      itemBuilder: (ctx, i) =>
                          _mealDetail(c.mealList[i], context),
                      separatorBuilder: (ctx, _) => SimpleDivider(
                            padding: EdgeInsets.symmetric(vertical: 2.5),
                          ),
                      itemCount: c.mealList.length);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealDetail(Meal meal, BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(meal.mealCategory.icon,
                  size: 22, color: meal.mealCategory.color),
              SizedBox(width: 10),
              Text(
                meal.mealCategory.name,
                style: textTheme.labelLarge,
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.alarm, size: 20, color: colorScheme.onSecondary),
              SizedBox(width: 5),
              Text(
                DateFormat('HH:mm').format(meal.dateTime),
                style: textTheme.labelLarge,
              )
            ],
          )
        ],
      ),
    );
  }
}
