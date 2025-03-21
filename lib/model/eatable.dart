import 'package:diet_app/model/food.dart';

import 'food_group.dart';

abstract class Eatable {
  String getPortionCalories();

  String getPortionCarbs();

  String getPortionProtein();

  String getPortionFat();

  Map<String, dynamic> toJson();

  Eatable(this.name, this.standardQuantity);

  final String name;

  final double standardQuantity;

  factory Eatable.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'food':
        return Food.fromJson(json);
      case 'foodGroup':
        return FoodGroup.fromJson(json);
      default:
        throw ArgumentError('tipo inválido de Eatable: ' + json['type']);
    }
  }

  String get nutritionData {
    return '${this.getPortionCalories()} kcal '
        '| ${this.getPortionCarbs()}C '
        '| ${this.getPortionProtein()}P '
        '| ${this.getPortionFat()}G '
        '• ${this.standardQuantity.toStringAsFixed(0)}${this is Food ? 'g' : 'U'}';
  }

  double get caloriesPerUnit;

  double get proteinPerUnit;

  double get carbsPerUnit;

  double get fatPerUnit;
}
