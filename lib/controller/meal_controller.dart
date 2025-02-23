import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/model/meal.dart';
import 'package:diet_app/model/meal_category_enum.dart';
import 'package:diet_app/model/meal_configuration.dart';
import 'package:get/get.dart';

class MealController extends GetxController {
  final List<Meal> mealList = [];
  bool mealListLoaded = false;

  @override
  void onInit() {
    super.onInit();
    loadMealList(DateTime.now());
  }

  void updateSelectedDate(DateTime date) {
    loadMealList(date);
  }

  void loadMealList(DateTime date) async {
    mealListLoaded = false;
    mealList.clear();
    var dbMealList = await _getMealListFromDB(date);
    dbMealList ??= await _getDefaultMealPlan(date);
    mealList.addAll(dbMealList);
    mealListLoaded = true;
    update();
  }

  Future<List<Meal>?> _getMealListFromDB(DateTime date) async {
    return null;
  }

  Future<List<Meal>> _getDefaultMealPlan(DateTime date) async {
    var mealConfiguration = await _getMealConfiguration();
    return mealConfiguration.userMealConfigurationList.map((mc) =>
        Meal(mealCategory: mc.mealCategory,
            foodEventList: [],
            dateTime: DateTime(date.year, date.month, date.day, mc.mealTime.hour, mc.mealTime.minute),
            calGoal: mc.calGoal,
            carbsGoal: mc.carbsGoal,
            proteinGoal: mc.proteinGoal,
            fatGoal: mc.fatGoal
        ),
    ).toList();
  }

  Future<MealConfiguration> _getMealConfiguration() async {
    List<UserMealConfiguration> userMealConfigurationList = [];
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.cafeDaManha,
      mealTime: DateTime(1970, 1, 1, 8, 0),
      calGoal: 400,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.lancheDaManha,
      mealTime: DateTime(1970, 1, 1, 10, 0),
      calGoal: 200,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.almoco,
      mealTime: DateTime(1970, 1, 1, 12, 0),
      calGoal: 600,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.lancheDaTarde,
      mealTime: DateTime(1970, 1, 1, 16, 0),
      calGoal: 200,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.jantar,
      mealTime: DateTime(1970, 1, 1, 19, 30),
      calGoal: 600,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.ceia,
      mealTime: DateTime(1970, 1, 1, 22, 0),
      calGoal: 150,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.ceia,
      mealTime: DateTime(1970, 1, 1, 22, 0),
      calGoal: 150,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    userMealConfigurationList.add(UserMealConfiguration(
      mealCategory: MealCategoryEnum.ceia,
      mealTime: DateTime(1970, 1, 1, 22, 0),
      calGoal: 150,
      carbsGoal: 200,
      proteinGoal: 300,
      fatGoal: 100,
    ));
    return MealConfiguration(userMealConfigurationList: userMealConfigurationList);
}
  void addFoodToMeal(String mealId, FoodEvent foodEvent) {
    final meal = mealList.firstWhere((element) => element.id == mealId);
    meal.foodEventList.add(foodEvent);
    update();
  }

}