import 'package:diet_app/model/food.dart';
import 'package:diet_app/service/food_service.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodPickerController extends GetxController {
  final FoodService _foodService = FoodService();

  final List<Food> foodList = [];
  List<Food> filteredFoodList = [];
  bool foodsLoaded = false;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    var storedFoods = await _foodService.findAll();
    foodList.addAll(storedFoods);
    foodList.sort((a, b) => a.name.compareTo(b.name));
    filteredFoodList.addAll(foodList);
    foodsLoaded = true;
    update();
  }

  Future<void> search(String text) async {
    if (text.isNotEmpty) {
      filteredFoodList = foodList.where((food) => Utils.contains(food.name, text.toLowerCase())).toList();
    } else {
      filteredFoodList = foodList;
    }
    update();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}