import 'package:csv/csv.dart';
import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_event.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final List<Food> foods = [];
  Food? selectedFood;
  bool foodsLoaded = false;
  final weightController = TextEditingController();

  @override
  void onInit() async {
    _loadFoods();
    super.onInit();
  }

  void _loadFoods() async {
    if (foods.isEmpty) {
      final rawData = await rootBundle.loadString("assets/comidasv1.csv");
      List<List<dynamic>> listData = const CsvToListConverter(
          fieldDelimiter: ';').convert(rawData);

      List<Food> parsedFoods = listData.skip(1).map((e) =>
          Food(
            name: e[0].toString(),
            standardQuantity: double.tryParse(e[1].toString()) ?? 0,
            caloriesPerUnit: double.tryParse(e[2].toString()) ?? 0,
            proteinPerUnit: double.tryParse(e[3].toString()) ?? 0,
            carbsPerUnit: double.tryParse(e[4].toString()) ?? 0,
            fatPerUnit: double.tryParse(e[5].toString()) ?? 0,
          )).toList();
      parsedFoods.sort((a, b) => a.name.compareTo(b.name));
      foods.addAll(parsedFoods);
    }
    foodsLoaded = true;
    update();
  }

  void setSelectedFood(Food? food) {
    selectedFood = food;
    weightController.text = food != null ? food.standardQuantity.toString() : '';
    update();
  }

  void addFoodToMeal(String mealId) {
    if (selectedFood != null) {
      final weight = double.tryParse(weightController.text) ?? 0;
      final foodEvent = FoodEvent(
        food: selectedFood!,
        quantity: weight,
      );
      Get.put(MealController()).addFoodToMeal(mealId, foodEvent);
    } else {
      Get.snackbar('Erro', 'Selecione um alimento');
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
}