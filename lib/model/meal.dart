import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/model/meal_category_enum.dart';
import 'package:uuid/uuid.dart';

class Meal {
  late final String id;
  final MealCategoryEnum mealCategory;
  final List<EatEvent> eatEventList;
  final DateTime dateTime;
  final double calGoal;
  final double carbsGoal;
  final double proteinGoal;
  final double fatGoal;

  Meal(
      {required this.mealCategory,
      required this.eatEventList,
      required this.dateTime,
      required this.calGoal,
      required this.carbsGoal,
      required this.proteinGoal,
      required this.fatGoal}) {
    id = Uuid().v4();
  }

  Meal._(
      {
        required this.id,
        required this.mealCategory,
        required this.eatEventList,
        required this.dateTime,
        required this.calGoal,
        required this.carbsGoal,
        required this.proteinGoal,
        required this.fatGoal});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealCategory': mealCategory.index,
      'foodEventList': eatEventList.map((event) => event.toJson()).toList(),
      'dateTime': dateTime.toIso8601String(),
      'calGoal': calGoal,
      'carbsGoal': carbsGoal,
      'proteinGoal': proteinGoal,
      'fatGoal': fatGoal,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal._(
      id: json['id'],
      mealCategory: MealCategoryEnum.values[json['mealCategory']],
      eatEventList: (json['foodEventList'] as List)
          .map((event) => EatEvent.fromJson(event))
          .toList(),
      dateTime: DateTime.parse(json['dateTime']),
      calGoal: json['calGoal'],
      carbsGoal: json['carbsGoal'],
      proteinGoal: json['proteinGoal'],
      fatGoal: json['fatGoal'],
    );
  }

  double getTotalCalories() {
    return eatEventList.fold(0, (sum, eatEvent) => sum + eatEvent.eatable.caloriesPerUnit * eatEvent.quantity);
  }

  double getTotalProtein() {
    return eatEventList.fold(0, (sum, eatEvent) => sum + eatEvent.eatable.proteinPerUnit * eatEvent.quantity);
  }

  double getTotalCarbs() {
    return eatEventList.fold(0, (sum, eatEvent) => sum + eatEvent.eatable.carbsPerUnit * eatEvent.quantity);
  }

  double getTotalFat() {
    return eatEventList.fold(0, (sum, eatEvent) => sum + eatEvent.eatable.fatPerUnit * eatEvent.quantity);
  }
}
