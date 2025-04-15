import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/model/eatable.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/pages/create_update_food_group_page.dart';
import 'package:diet_app/pages/create_update_food_page.dart';
import 'package:diet_app/service/food_group_service.dart';
import 'package:diet_app/service/food_service.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/material.dart';
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
    eatableList.sort((a, b) => Utils.compareTo(a.name, b.name));
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

  void onEatableSelect(Eatable eatable) {
    if (eatable is Food) {
      Get.to(() => CreateUpdateFoodPage(food: eatable))?.then((result) => handleResult(result));
    } else if (eatable is FoodGroup) {
      Get.to(() => CreateUpdateFoodGroupPage(foodGroup: eatable))?.then((result) => handleResult(result));
    } else {
      throw ArgumentError('tipo inválido de Eatable: ${eatable.runtimeType}');
    }
  }

  void handleResult(Map<String, dynamic>? result) {
    final colorScheme = Theme.of(Get.context!).colorScheme;
    if (result == null) return;
    if (result['action'] == 'save') {
      Get.snackbar(
        'Sucesso!',
        'Salvo com sucesso!',
        duration: Duration(seconds: 3),
        backgroundColor: colorScheme.success,
        backgroundGradient: RadialGradient(
          colors: [colorScheme.successGradientEnd, colorScheme.successGradientStart],
        ),
      );
      saveEatable(result['food'] as Eatable);
    } else if (result['action'] == 'delete') {
      Get.snackbar(
        'Removido!',
        'Excluído com sucesso!',
        duration: Duration(seconds: 3),
        backgroundColor: colorScheme.success,
        backgroundGradient: RadialGradient(
          colors: [colorScheme.successGradientEnd, colorScheme.successGradientStart],
        ),
      );
      deleteEatable(result['food'] as Eatable);
    }
  }

  void addEatable() {
    if (showFoods) {
      Get.to(() => CreateUpdateFoodPage())?.then((result) => handleResult(result));
    } else if (showFoodGroups) {
      Get.to(() => CreateUpdateFoodGroupPage())?.then((result) => handleResult(result));
    } else {
      throw ArgumentError('tipo inválido de Eatable: ${eatableList.runtimeType}');
    }
  }

  Future<void> saveEatable(Eatable eatable) async {
    var index = eatableList.indexWhere((el) => el.id == eatable.id);
    if (index != -1) {
      eatableList[index] = eatable;
    } else {
      eatableList.add(eatable);
      eatableList.sort((a, b) => Utils.compareTo(a.name, b.name));
    }
    filteredEatableList = eatableList;
    if (eatable is Food) {
      await _foodService.save(eatable);
    } else if (eatable is FoodGroup) {
      await _foodGroupService.save(eatable);
    } else {
      throw ArgumentError('tipo inválido de Eatable: ${eatable.runtimeType}');
    }
    update();
  }

  Future<void> deleteEatable(Eatable eatable) async {
    eatableList.remove(eatable);
    filteredEatableList = eatableList;
    if (eatable is Food) {
      await _foodService.delete(eatable);
    } else if (eatable is FoodGroup) {
      await _foodGroupService.delete(eatable);
    } else {
      throw ArgumentError('tipo inválido de Eatable: ${eatable.runtimeType}');
    }
    update();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}
