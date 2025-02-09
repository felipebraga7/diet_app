import 'package:diet_app/main.dart';
import 'package:flutter/material.dart';
import '../model/food.dart';
import '../util/utils.dart';

class MealSummary extends StatelessWidget {
  final List<Food> meals;

  const MealSummary({super.key, required this.meals});

  double getTotalCalories(List<Food> meals) {
    return meals.fold(0, (sum, food) => sum + food.calories);
  }

  double getTotalProtein(List<Food> meals) {
    return meals.fold(0, (sum, food) => sum + food.protein);
  }

  double getTotalCarbs(List<Food> meals) {
    return meals.fold(0, (sum, food) => sum + food.carbs);
  }

  double getTotalFat(List<Food> meals) {
    return meals.fold(0, (sum, food) => sum + food.fat);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customSwatch.shade300,
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryBox('Kcal', getTotalCalories(meals)),
            _buildSummaryBox('Prot.', getTotalProtein(meals), suffix: 'g'),
            _buildSummaryBox('Carb.', getTotalCarbs(meals), suffix: 'g'),
            _buildSummaryBox('Gord.', getTotalFat(meals), suffix: 'g'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBox(String title, double value, {String suffix = ''}) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('${Utils.formatNumber(value)}$suffix', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}