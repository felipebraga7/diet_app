import 'package:diet_app/main.dart';
import 'package:flutter/material.dart';
import '../model/food.dart';
import 'package:diet_app/util/utils.dart';

class DietSummary extends StatefulWidget {
  final List<Food> foods;
  final DateTime selectedDate;

  const DietSummary({super.key, required this.foods, required this.selectedDate});

  @override
  _DietSummaryState createState() => _DietSummaryState();
}

class _DietSummaryState extends State<DietSummary> {
  List<Food> getFilteredFoods() {
    return widget.foods.where((food) {
      return food.date != null &&
          food.date!.year == widget.selectedDate.year &&
          food.date!.month == widget.selectedDate.month &&
          food.date!.day == widget.selectedDate.day;
    }).toList();
  }

  double getTotalCalories() {
    return getFilteredFoods().fold(0, (sum, food) => sum + food.calories);
  }

  double getTotalProtein() {
    return getFilteredFoods().fold(0, (sum, food) => sum + food.protein);
  }

  double getTotalCarbs() {
    return getFilteredFoods().fold(0, (sum, food) => sum + food.carbs);
  }

  double getTotalFat() {
    return getFilteredFoods().fold(0, (sum, food) => sum + food.fat);
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
              _buildSummaryBox('Kcal', getTotalCalories()),
              _buildSummaryBox('Prot.', getTotalProtein(), suffix: 'g'),
              _buildSummaryBox('Carb.', getTotalCarbs(), suffix: 'g'),
              _buildSummaryBox('Gord.', getTotalFat(), suffix: 'g'),
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