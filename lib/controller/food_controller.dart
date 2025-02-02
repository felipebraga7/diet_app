import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import '../model/food.dart';

class FoodController extends GetxController {
  var foods = <Food>[].obs; // List of all foods from CSV
  var dietFoods = <Food>[].obs; // List of foods added to the diet
  final Box<Food> foodBox = Hive.box<Food>('foods');
  final Box<Food> dietBox = Hive.box<Food>('dietFoods');

  @override
  void onInit() {
    super.onInit();
    loadFoods();
    loadDietFoods();
  }

  void addFood(Food food) {
    dietFoods.add(food);
    dietBox.add(food);
  }

  void deleteFood(Food food) {
    final key = dietBox.keys.firstWhere((k) => dietBox.get(k) == food,
        orElse: () => null);
    if (key != null) {
      dietBox.delete(key);
      dietFoods.remove(food);
    }
  }

  void loadDietFoods() {
    dietFoods.assignAll(dietBox.values);
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
      foodBox.addAll(parsedFoods);
    }
    foods.assignAll(foodBox.values);
  }

  void updateFood(Food oldFood, Food newFood) {
    final key = dietBox.keys.firstWhere((k) => dietBox.get(k) == oldFood,
        orElse: () => null);
    if (key != null) {
      dietBox.put(key, newFood);
      final index = dietFoods.indexOf(oldFood);
      if (index != -1) {
        dietFoods[index] = newFood;
        update();
      }
    }
  }
}