import 'dart:convert';

import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/service/food_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodGroupService {
  static final FoodGroupService _instance = FoodGroupService._();
  static final String _key = 'foodGroupList';
  final FoodService _foodService = FoodService();
  late final SharedPreferencesWithCache prefsWithCache;

  factory FoodGroupService() {
    return _instance;
  }

  FoodGroupService._();

  Future<void> initialize() async {
    prefsWithCache = await SharedPreferencesWithCache.create(cacheOptions: const SharedPreferencesWithCacheOptions());
    final storedFoodGroupList = prefsWithCache.getStringList(_key);
    if (storedFoodGroupList == null) {
      await _replaceAll(await _getInitialFoodGroupList());
    }
  }

  Future<List<FoodGroup>> findAll() async {
    final storedFoodGroupList = prefsWithCache.getStringList(_key);
    if (storedFoodGroupList != null) {
      return storedFoodGroupList.map((item) => FoodGroup.fromJson(jsonDecode(item))).toList();
    }
    return [];
  }

  Future<void> _replaceAll(List<FoodGroup> foodGroupList) async {
    final jsonList = foodGroupList.map((foodGroup) => jsonEncode(foodGroup.toJson())).toList();
    await prefsWithCache.setStringList(_key, jsonList);
  }

  Future<void> save(FoodGroup foodGroup) async {
    var foodGroupList = await findAll();
    int index = foodGroupList.indexWhere((foodGroupDb) => foodGroup.name == foodGroupDb.name);
    if (index != -1) {
      foodGroupList[index] = foodGroup;
    } else {
      foodGroupList.add(foodGroup);
    }
    _replaceAll(foodGroupList);
  }

  Future<void> delete(FoodGroup foodGroup) async {
    var foodGroupList = await findAll();
    int index = foodGroupList.indexWhere((foodGroupDb) => foodGroup.name == foodGroupDb.name);
    if (index != -1) {
      foodGroupList.removeAt(index);
      _replaceAll(foodGroupList);
    }
  }

  Future<List<FoodGroup>> _getInitialFoodGroupList() async {
      var foodList = await _foodService.findAll();
      List<FoodGroup> fgList = [];
      var arroz = foodList.where((food) => food.name == 'Arroz').first;
      var feijao = foodList.where((food) => food.name == 'Feijão').first;
      var frango = foodList.where((food) => food.name == 'Peito de frango').first;
      fgList.add(FoodGroup(name: 'Almoço', foodQuantityList: [FoodQuantity(arroz, 150), FoodQuantity(feijao, 150), FoodQuantity(frango, 200)]));
      fgList.add(FoodGroup(name: 'Jantar', foodQuantityList: [FoodQuantity(arroz, 150), FoodQuantity(feijao, 150), FoodQuantity(frango, 150)]));
      return fgList;
  }
}
