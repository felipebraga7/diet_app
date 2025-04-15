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
                Expanded(
                  flex: 35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: SizedBox(
                          width: double.infinity,
                          child: CircularProgressIndicator(
                            value: calGoal == 0 ? 0 : (_getTotalCalories(c.mealList) / calGoal),
                            strokeWidth: 10,
                            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                            backgroundColor: colorScheme.secondary,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(_getTotalCalories(c.mealList).toStringAsFixed(0), style: textTheme.bodyLarge),
                          Text(
                            'Calorias',
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       _buildMacroSummary(context, 'Carb.', _getTotalCarbs(c.mealList), 300),
                       _buildMacroSummary(context, 'Proteína', _getTotalProtein(c.mealList), 190),
                       _buildMacroSummary(context, 'Gordura', _getTotalFat(c.mealList), 60)
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 38,
              child: Text('${(percentage*100).toStringAsFixed(0)}%',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurface,
                  )),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 8,
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: colorScheme.secondary,
                    valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: Text('${value.toStringAsFixed(0)} g',
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurface,
                  )),
            ),

          ],
        )
      ],
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
