import 'dart:convert';

import 'package:diet_app/model/food.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodService {
  static final FoodService _instance = FoodService._();
  static final String _key = 'foodList';
  late final SharedPreferencesWithCache prefsWithCache;

  factory FoodService() {
    return _instance;
  }

  FoodService._();

  Future<void> initialize() async {
    prefsWithCache = await SharedPreferencesWithCache.create(cacheOptions: const SharedPreferencesWithCacheOptions());
    final storedFoods = prefsWithCache.getStringList(_key);
    if (storedFoods == null) {
      await _replaceAll(_getInitialFoodList());
    }
  }

  Future<List<Food>> findAll() async {
    final storedFoodList = prefsWithCache.getStringList(_key);
    if (storedFoodList != null) {
      return storedFoodList.map((item) => Food.fromJson(jsonDecode(item))).toList();
    }
    return [];
  }

  Future<void> _replaceAll(List<Food> foodList) async {
    final jsonList = foodList.map((food) => jsonEncode(food.toJson())).toList();
    await prefsWithCache.setStringList(_key, jsonList);
  }

  Future<void> save(Food food) async {
    var foodList = await findAll();
    int index = foodList.indexWhere((foodDb) => food.id == foodDb.id);
    if (index != -1) {
      foodList[index] = food;
    } else {
      foodList.add(food);
    }
    _replaceAll(foodList);
  }

  Future<void> delete(Food food) async {
    var foodList = await findAll();
    int index = foodList.indexWhere((foodDb) => food.id == foodDb.id);
    if (index != -1) {
      foodList.removeAt(index);
      _replaceAll(foodList);
    }
  }

  List<Food> _getInitialFoodList() {
    List<Food> foodList = [];
    foodList.add(Food(name: 'Arroz', standardQuantity: 100, caloriesPerUnit: 1.24, proteinPerUnit: 0.026, carbsPerUnit: 0.231, fatPerUnit: 0.01));
    foodList.add(Food(name: 'Feijão', standardQuantity: 100, caloriesPerUnit: 0.76, proteinPerUnit: 0.048, carbsPerUnit: 0.136, fatPerUnit: 0.005));
    foodList.add(Food(name: 'Peito de frango', standardQuantity: 100, caloriesPerUnit: 1.63, proteinPerUnit: 0.315, carbsPerUnit: 0, fatPerUnit: 0.032));
    foodList.add(Food(name: 'Creme de ricota', standardQuantity: 100, caloriesPerUnit: 1.47, proteinPerUnit: 0.09, carbsPerUnit: 0.027, fatPerUnit: 0.11));
    foodList.add(Food(name: 'Cenoura', standardQuantity: 100, caloriesPerUnit: 0.34, proteinPerUnit: 0.013, carbsPerUnit: 0.077, fatPerUnit: 0.002));
    foodList.add(Food(name: 'Pão integral', standardQuantity: 100, caloriesPerUnit: 2.56, proteinPerUnit: 0.11, carbsPerUnit: 0.47, fatPerUnit: 0.028));
    foodList.add(Food(name: 'Morango', standardQuantity: 100, caloriesPerUnit: 0.33, proteinPerUnit: 0.007, carbsPerUnit: 0.08, fatPerUnit: 0.003));
    foodList.add(Food(name: 'Whey protein', standardQuantity: 30, caloriesPerUnit: 4.066, proteinPerUnit: 0.6666, carbsPerUnit: 0.18, fatPerUnit: 0.0766));
    foodList.add(Food(name: 'Aveia', standardQuantity: 20, caloriesPerUnit: 2.46, proteinPerUnit: 0.173, carbsPerUnit: 0.662, fatPerUnit: 0.0705));
    foodList.add(Food(name: 'YoPro', standardQuantity: 1, caloriesPerUnit: 157.5, proteinPerUnit: 15, carbsPerUnit: 18.75, fatPerUnit: 2.25));
    foodList.add(Food(name: 'Ovo', standardQuantity: 1, caloriesPerUnit: 73, proteinPerUnit: 6.65, carbsPerUnit: 0.3, fatPerUnit: 4.75));
    foodList.add(Food(name: 'Almoço', standardQuantity: 1, caloriesPerUnit: 432.4, proteinPerUnit: 42.18, carbsPerUnit: 44.58, fatPerUnit: 7.2));
    foodList.add(Food(name: 'Jantar', standardQuantity: 1, caloriesPerUnit: 451.4, proteinPerUnit: 43.85, carbsPerUnit: 35.49, fatPerUnit: 11.65));
    foodList.add(Food(name: 'Shake sem aveia', standardQuantity: 1, caloriesPerUnit: 188, proteinPerUnit: 21.4, carbsPerUnit: 21.4, fatPerUnit: 2.9));
    foodList.add(Food(name: 'Shake com aveia', standardQuantity: 1, caloriesPerUnit: 237.2, proteinPerUnit: 24.86, carbsPerUnit: 34.64, fatPerUnit: 4.31));
    foodList.add(Food(name: 'Sanduíche duplo', standardQuantity: 1, caloriesPerUnit: 276.8625, proteinPerUnit: 25.9875, carbsPerUnit: 31.1737, fatPerUnit: 5.1375));
    foodList.add(Food(name: 'Sanduíche triplo', standardQuantity: 1, caloriesPerUnit: 369.15, proteinPerUnit: 34.65, carbsPerUnit: 41.565, fatPerUnit: 6.85));
    foodList.add(Food(name: 'Whey Viv', standardQuantity: 1, caloriesPerUnit: 142, proteinPerUnit: 19, carbsPerUnit: 13, fatPerUnit: 3.3));
    foodList.add(Food(name: 'Amendoim', standardQuantity: 100, caloriesPerUnit: 5.67, proteinPerUnit: 0.26, carbsPerUnit: 0.06, fatPerUnit: 0.49));
    return foodList;
  }
}
