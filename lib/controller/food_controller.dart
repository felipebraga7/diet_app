import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import '../model/food.dart';

class FoodController extends GetxController {
  var foods = <Food>[].obs; // List of all foods from CSV
  var meals = <Food>[].obs; // List of meals
  final Box<Food> foodBox = Hive.box<Food>('foods');
  final Box<Food> mealBox = Hive.box<Food>('meals');
  DateTime selectedDate = DateTime.now();
  Food? selectedFood;
  double calories = 0;
  double protein = 0;
  double carbs = 0;
  double fat = 0;

  @override
  void onInit() {
    super.onInit();
    loadFoods();
    loadMeals(DateTime.now());
  }

  void addMeal(Food food) {
    meals.add(food);
    mealBox.add(food);
    update();
  }

  void deleteMeal(Food food) {
    final key = mealBox.keys.firstWhere((k) => mealBox.get(k) == food,
        orElse: () => null);
    if (key != null) {
      mealBox.delete(key);
      meals.remove(food);
    }
    update();
  }

  void editMeal(Food oldMeal, Food newMeal) {
    final key = mealBox.keys.firstWhere((k) => mealBox.get(k) == oldMeal,
        orElse: () => null);
    if (key != null) {
      mealBox.put(key, newMeal);
      final index = meals.indexOf(oldMeal);
      if (index != -1) {
        meals[index] = newMeal;
        update();
      }
    }
  }

  void loadMeals(DateTime selectedDate) {
    meals.assignAll(
        mealBox.values.where((food) {
          return food.date != null &&
              food.date!.year == selectedDate.year &&
              food.date!.month == selectedDate.month &&
              food.date!.day == selectedDate.day;
        }).toList());
    update();
  }

  void loadFoods() async {
    if (foodBox.isEmpty) {
      final _rawData = await rootBundle.loadString("assets/import alimentos.csv");
      List<List<dynamic>> _listData = const CsvToListConverter(
          fieldDelimiter: ';').convert(_rawData);

      List<Food> parsedFoods = _listData.skip(1).map((e) =>
          Food(
            name: e[0].toString(),
            weight: double.tryParse(e[1].toString()) ?? 0,
            calories: double.tryParse(e[2].toString()) ?? 0,
            protein: double.tryParse(e[3].toString()) ?? 0,
            carbs: double.tryParse(e[4].toString()) ?? 0,
            fat: double.tryParse(e[5].toString()) ?? 0,
            date: DateTime.now(),
          )).toList();
      parsedFoods.sort((a, b) => a.name.compareTo(b.name));
      foodBox.addAll(parsedFoods);
    }
    foods.assignAll(foodBox.values);
    update();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    loadMeals(date);
  }
}