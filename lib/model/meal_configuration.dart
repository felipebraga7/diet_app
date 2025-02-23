import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/model/meal_category_enum.dart';
import 'package:uuid/uuid.dart';

class MealConfiguration {
  late final String id;
  List<UserMealConfiguration> userMealConfigurationList;

  MealConfiguration({required this.userMealConfigurationList}) {
    id = Uuid().v4();
  }
}

class UserMealConfiguration {
  final MealCategoryEnum mealCategory;
  final DateTime mealTime;
  final double calGoal;
  final double carbsGoal;
  final double proteinGoal;
  final double fatGoal;

  UserMealConfiguration({required this.mealCategory, required this.mealTime, required this.calGoal, required this.carbsGoal, required this.proteinGoal, required this.fatGoal,}) {}
}
