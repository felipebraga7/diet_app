import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/meal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealSummary extends StatelessWidget {

  const MealSummary({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<MealController>(
          init: MealController(),
          builder: (c) {
            if (!c.mealListLoaded) {
              return CircularProgressIndicator();
            }
            var calGoal = _getTotalCaloriesGoal(c.mealList);
            return Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: CircularProgressIndicator(
                        value: calGoal == 0 ? 0 : (_getTotalCalories(c.mealList) / calGoal),
                        strokeWidth: 10,
                        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                        backgroundColor: colorScheme.secondary,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      children: [
                        Text(_getTotalCalories(c.mealList).toStringAsFixed(0), style: textTheme.headlineLarge),
                        Text(
                          'Calorias',
                          style: textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMacroSummary(context, 'Carboidratos', _getTotalCarbs(c.mealList), 200),
                      _buildMacroSummary(context, 'Proteína', _getTotalProtein(c.mealList), 200),
                      _buildMacroSummary(context, 'Gordura', _getTotalFat(c.mealList), 200)
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMacroSummary(BuildContext context, String title, double value, double goal) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    double percentage = (value / goal).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          Row(
            children: [
              Text(
                '${(percentage * 100).toStringAsFixed(0)}%',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 55,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: colorScheme.secondary.withOpacity(0.3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.transparent,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(colorScheme.primary),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '${value.toStringAsFixed(0)} g',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _getTotalCalories(List<Meal> meals) {
    return meals.fold(0, (sum, meal) => sum + meal.getTotalCalories());
  }

  double _getTotalCaloriesGoal(List<Meal> meals) {
    return meals.fold(0, (sum, meal) => sum + meal.calGoal);
  }

  double _getTotalProtein(List<Meal> meals) {
    return meals.fold(0, (sum, meal) => sum + meal.getTotalProtein());
  }

  double _getTotalCarbs(List<Meal> meals) {
    return meals.fold(0, (sum, meal) => sum + meal.getTotalCarbs());
  }

  double _getTotalFat(List<Meal> meals) {
    return meals.fold(0, (sum, meal) => sum + meal.getTotalFat());
  }
}
