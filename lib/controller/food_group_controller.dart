import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/service/food_group_service.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodGroupController extends GetxController {
  final FoodGroupService _foodGroupService = FoodGroupService();

  final List<FoodGroup> foodGroupList = [];
  List<FoodGroup> filteredFoodGroupList = [];
  FoodGroup? selectedFoodGroup;
  bool foodGroupsLoaded = false;
  final weightController = TextEditingController();
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadFoodGroups();
  }

  Future<void> _loadFoodGroups() async {
    var storedFoodGroups = await _foodGroupService.findAll();
    foodGroupList.addAll(storedFoodGroups);
    foodGroupList.sort((a, b) => a.name.compareTo(b.name));
    filteredFoodGroupList.addAll(foodGroupList);
    foodGroupsLoaded = true;
    update();
  }

  Future<void> search(String text) async {
    if (text.isNotEmpty) {
      filteredFoodGroupList = foodGroupList.where((food) => Utils.contains(food.name, text.toLowerCase())).toList();
    } else {
      filteredFoodGroupList = foodGroupList;
    }
    update();
  }

  Future<void> saveFoodGroup(FoodGroup foodGroup) async {
    var index = foodGroupList.indexWhere((el) => el.id == foodGroup.id);
    if (index != -1) {
      foodGroupList[index] = foodGroup;
    } else {
      foodGroupList.add(foodGroup);
      foodGroupList.sort((a, b) => Utils.compareTo(a.name, b.name));
    }
    filteredFoodGroupList = foodGroupList;
    await _foodGroupService.save(foodGroup);
    update();
  }

  Future<void> deleteFoodGroup(FoodGroup foodGroup) async {
    foodGroupList.remove(foodGroup);
    filteredFoodGroupList = foodGroupList;
    await _foodGroupService.delete(foodGroup);
    update();
  }

  @override
  void dispose() {
    weightController.dispose();
    searchTextController.dispose();
    super.dispose();
  }
}