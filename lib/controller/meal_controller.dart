import 'package:diet_app/controller/bottom_menu_controller.dart';
import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/model/meal.dart';
import 'package:diet_app/model/meal_category_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MealController extends GetxController {
  final List<Meal> mealList = [];
  bool mealListLoaded = false;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = Get.put(BottomMenuController()).scrollController;
  }

  void updateSelectedDate(DateTime date) {
    loadMeals(date);
  }

  void loadMeals(DateTime dateToLoad) async {
    mealListLoaded = false;
    mealList.clear();
    _getDefaultMealPlan().then((newMealList) {
      mealList.addAll(newMealList);
      mealListLoaded = true;
      update();
    });
    update();
  }

  void addFoodToMeal(String mealId, FoodEvent foodEvent) {
    final meal = mealList.firstWhere((element) => element.id == mealId);
    meal.foodEventList.add(foodEvent);
    update();
  }

  Future<List<Meal>> _getDefaultMealPlan() async {
    List<Meal> defaultMeals = [];
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.cafeDaManha,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 8, 0),
      calGoal: 400,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.lancheDaManha,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 10, 0),
      calGoal: 200,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.almoco,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 12, 0),
      calGoal: 600,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.lancheDaTarde,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 16, 0),
      calGoal: 200,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.jantar,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 19, 30),
      calGoal: 600,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.ceia,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 22, 0),
      calGoal: 150,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.ceia,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 22, 0),
      calGoal: 150,
    ));
    defaultMeals.add(Meal(
      mealCategory: MealCategoryEnum.ceia,
      foodEventList: [],
      dateTime: DateTime(1970, 1, 1, 22, 0),
      calGoal: 150,
    ));
    return defaultMeals;
  }
}