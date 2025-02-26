import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/model/meal_category_enum.dart';
import 'package:uuid/uuid.dart';

class Meal {
  late final String id;
  final MealCategoryEnum mealCategory;
  final List<FoodEvent> foodEventList;
  final DateTime dateTime;
  final double calGoal;
  final double carbsGoal;
  final double proteinGoal;
  final double fatGoal;

  Meal(
      {required this.mealCategory,
      required this.foodEventList,
      required this.dateTime,
      required this.calGoal,
      required this.carbsGoal,
      required this.proteinGoal,
      required this.fatGoal}) {
    id = Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealCategory': mealCategory.index,
      'foodEventList': foodEventList.map((event) => event.toJson()).toList(),
      'dateTime': dateTime.toIso8601String(),
      'calGoal': calGoal,
      'carbsGoal': carbsGoal,
      'proteinGoal': proteinGoal,
      'fatGoal': fatGoal,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealCategory: MealCategoryEnum.values[json['mealCategory']],
      foodEventList: (json['foodEventList'] as List)
          .map((event) => FoodEvent.fromJson(event))
          .toList(),
      dateTime: DateTime.parse(json['dateTime']),
      calGoal: json['calGoal'],
      carbsGoal: json['carbsGoal'],
      proteinGoal: json['proteinGoal'],
      fatGoal: json['fatGoal'],
    );
  }

  double getTotalCalories() {
    return foodEventList.fold(0, (sum, foodEvent) => sum + foodEvent.food.caloriesPerUnit * foodEvent.quantity);
  }

  double getTotalProtein() {
    return foodEventList.fold(0, (sum, foodEvent) => sum + foodEvent.food.proteinPerUnit * foodEvent.quantity);
  }

  double getTotalCarbs() {
    return foodEventList.fold(0, (sum, foodEvent) => sum + foodEvent.food.carbsPerUnit * foodEvent.quantity);
  }

  double getTotalFat() {
    return foodEventList.fold(0, (sum, foodEvent) => sum + foodEvent.food.fatPerUnit * foodEvent.quantity);
  }
}
