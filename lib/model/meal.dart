import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/model/meal_category_enum.dart';
import 'package:uuid/uuid.dart';

class Meal {
  late final String id;
  final MealCategoryEnum mealCategory;
  final List<FoodEvent> foodEventList;
  final DateTime dateTime;
  final double calGoal;

  Meal({required this.mealCategory, required this.foodEventList, required this.dateTime, required this.calGoal}) {
    id = Uuid().v4();
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
