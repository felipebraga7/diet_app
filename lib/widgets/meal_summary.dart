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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: GetBuilder<MealController>(
            init: MealController(),
            builder: (c) {
              if (!c.mealListLoaded) {
                return CircularProgressIndicator();
              }
              var calGoal = _getTotalCaloriesGoal(c.mealList);
              debugPrint('calGoal - $calGoal');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: calGoal == 0 ? 0 : (_getTotalCalories(c.mealList) / calGoal),
                          strokeWidth: 8,
                          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                          backgroundColor: colorScheme.secondary,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_getTotalCalories(c.mealList).toStringAsFixed(0), style: textTheme.headlineMedium),
                          Text(
                            'Calorias',
                            style: textTheme.labelMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMacroSummary(context, 'Carboidratos', _getTotalCarbs(c.mealList), 200),
                      _buildMacroSummary(context, 'Proteína', _getTotalProtein(c.mealList), 200),
                      _buildMacroSummary(context, 'Gordura', _getTotalFat(c.mealList), 200)
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget _buildMacroSummary(BuildContext context, String title, double value, double goal) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: textTheme.labelMedium),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 4,
              child: LinearProgressIndicator(
                value: goal == 0 ? 0 : (value / goal),
                backgroundColor: colorScheme.secondary,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
          ),
          Text('${value.toStringAsFixed(0)}/${goal.toStringAsFixed(0)}', style: textTheme.headlineSmall),
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
