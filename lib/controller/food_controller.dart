import 'package:csv/csv.dart';
import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final List<Food> foodList = [];
  List<Food> filteredFoodList = [];
  Food? selectedFood;
  bool foodsLoaded = false;
  final weightController = TextEditingController();
  final searchTextController = TextEditingController();

  @override
  void onInit() async {
    _loadFoods();
    super.onInit();
  }

  void _loadFoods() async {
    if (foodList.isEmpty) {
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
      foodList.addAll(parsedFoods);
      filteredFoodList.addAll(parsedFoods);
    }
    foodsLoaded = true;
    update();
  }

  void setSelectedFood(Food? food) {
    selectedFood = food;
    weightController.text = food != null ? food.standardQuantity.toString() : '';
    update();
  }

  void addFoodEventToMeal(String mealId) {
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

  Future<void> search(String text) async {
    if (text.isNotEmpty) {
      filteredFoodList = foodList.where((food) => Utils.contains(food.name, text.toLowerCase())).toList();
    } else {
      filteredFoodList = foodList;
    }
    update();
  }

  void createUpdateFood(Food food) {
    var index = foodList.indexWhere((el) => el.id == food.id);
    if (index != -1) {
      foodList[index] = food;
    } else {
      foodList.add(food);
      foodList.sort((a, b) => Utils.compareTo(a.name, b.name));
    }
    filteredFoodList = foodList;
    update();
  }

  @override
  void dispose() {
    weightController.dispose();
    searchTextController.dispose();
    super.dispose();
  }
}