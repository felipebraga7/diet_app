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

  void loadFoods() {
    foods.assignAll(foodBox.values.toList());
  }

  void addFood(Food food) {
    foodBox.add(food);
    foods.add(food);
  }
}