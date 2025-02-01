import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/food.dart';

class FoodController extends GetxController {
  var foods = <Food>[].obs;
  final Box<Food> foodBox = Hive.box<Food>('foods');

  @override
  void onInit() {
    super.onInit();
    loadFoods();
  }

  void addFood(Food food) {
    foodBox.add(food);
    foods.add(food);
  }

  void deleteFood(Food food) {
    foodBox.delete(food);
    foods.remove(food);
  }

  void loadFoods() {
    foods.assignAll(foodBox.values.toList());
  }

  void updateFood(Food oldFood, Food newFood) {
    final index = foods.indexOf(oldFood);
    if (index != -1) {
      foods[index] = newFood;
      foodBox.putAt(index, newFood);
      update();
    }
  }
}