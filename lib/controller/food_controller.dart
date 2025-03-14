import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/service/food_service.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final FoodService _foodService = FoodService();

  final List<Food> foodList = [];
  List<Food> filteredFoodList = [];
  Food? selectedFood;
  bool foodsLoaded = false;
  final weightController = TextEditingController();
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    var storedFoods = await _foodService.findAll();
    foodList.addAll(storedFoods);
    foodList.sort((a, b) => Utils.compareTo(a.name, b.name));
    filteredFoodList.addAll(foodList);
    foodsLoaded = true;
    update();
  }

  void setSelectedFood(Food? food) {
    selectedFood = food;
    weightController.text = food != null ? food.standardQuantity.toString() : '';
    update();
  }

  void addEatEventToMeal(String mealId) {
    if (selectedFood != null) {
      final weight = double.tryParse(weightController.text) ?? 0;
      final foodEvent = EatEvent(
        eatable: selectedFood!,
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

  Future<void> saveFood(Food food) async {
    var index = foodList.indexWhere((el) => el.id == food.id);
    if (index != -1) {
      foodList[index] = food;
    } else {
      foodList.add(food);
      foodList.sort((a, b) => Utils.compareTo(a.name, b.name));
    }
    filteredFoodList = foodList;
    await _foodService.save(food);
    update();
  }

  Future<void> deleteFood(Food food) async {
    foodList.remove(food);
    filteredFoodList = foodList;
    await _foodService.delete(food);
    update();
  }

  @override
  void dispose() {
    weightController.dispose();
    searchTextController.dispose();
    super.dispose();
  }

}
