import 'package:flutter/material.dart';
import '../model/food.dart';

class DietSummary extends StatefulWidget {
  final List<Food> foods;

  const DietSummary({super.key, required this.foods});

  @override
  _DietSummaryState createState() => _DietSummaryState();
}

class _DietSummaryState extends State<DietSummary> {
  double getTotalCalories() {
    return widget.foods.fold(0, (sum, food) => sum + food.calories);
  }

  double getTotalProtein() {
    return widget.foods.fold(0, (sum, food) => sum + food.protein);
  }

  double getTotalCarbs() {
    return widget.foods.fold(0, (sum, food) => sum + food.carbs);
  }

  double getTotalFat() {
    return widget.foods.fold(0, (sum, food) => sum + food.fat);
  }

  String formatNumber(double number) {
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 8.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryBox('Kcal', getTotalCalories(), Colors.red),
                _buildSummaryBox('Prot', getTotalProtein(), Colors.purple, suffix: 'g'),
                _buildSummaryBox('Carb', getTotalCarbs(), Colors.orange, suffix: 'g'),
                _buildSummaryBox('Gord', getTotalFat(), Colors.brown, suffix: 'g'),
              ],
            ),
          ],
      ),
    );
  }

  Widget _buildSummaryBox(String title, double value, Color color, {String suffix = ''}) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 5),
        Text('${formatNumber(value)}$suffix', style: TextStyle(fontSize: 20, color: color)),
      ],
    );
  }
}