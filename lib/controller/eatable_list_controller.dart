import 'package:diet_app/model/eatable.dart';
import 'package:diet_app/service/food_group_service.dart';
import 'package:diet_app/service/food_service.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EatableListController extends GetxController {
  final FoodService _foodService = FoodService();
  final FoodGroupService _foodGroupService = FoodGroupService();

  final List<Eatable> eatableList = [];
  List<Eatable> filteredEatableList = [];
  bool eatablesLoaded = false;
  final searchTextController = TextEditingController();

  final bool showFoods;
  final bool showFoodGroups;

  EatableListController({this.showFoods = true, this.showFoodGroups = true});

  @override
  void onInit() {
    super.onInit();
    _loadEatables();
  }

  Future<void> _loadEatables() async {
    if (showFoods) {
      eatableList.addAll(await _foodService.findAll());
    }
    if (showFoodGroups) {
      eatableList.addAll(await _foodGroupService.findAll());
    }
    eatableList.sort((a, b) => a.name.compareTo(b.name));
    filteredEatableList.addAll(eatableList);
    eatablesLoaded = true;
    update();
  }

  Future<void> search(String text) async {
    if (text.isNotEmpty) {
      filteredEatableList = eatableList.where((eatable) => Utils.contains(eatable.name, text.toLowerCase())).toList();
    } else {
      filteredEatableList = eatableList;
    }
    update();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}