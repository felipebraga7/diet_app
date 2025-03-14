import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_group.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateUpdateFoodGroupController extends GetxController {
  FoodGroup? foodGroup;
  List<FoodQuantityHelper> selectedFoodQuantityList = [];

  final nameController = TextEditingController();

  String errorMessage = '';

  CreateUpdateFoodGroupController({
    required this.foodGroup,
  });

  @override
  void onInit() {
    super.onInit();
    loadFoodGroupData();
  }

  void loadFoodGroupData() async {
    if (foodGroup != null) {
      nameController.text = foodGroup!.name;
      selectedFoodQuantityList.addAll(
          foodGroup!.foodQuantityList.map((fq) => FoodQuantityHelper(food: fq.food, controller: TextEditingController(text: fq.quantity.toString()))));
    }
  }

  void addFood(Food food) {
    selectedFoodQuantityList.add(FoodQuantityHelper(food: food, controller: TextEditingController()));
    update();
  }

  void removeFood(FoodQuantityHelper fh) {
    selectedFoodQuantityList.remove(fh);
    update();
  }

  void saveFoodGroup() async {
    if (_validate()) {
      foodGroup ??= FoodGroup.empty();
      foodGroup = foodGroup!.copyWith(
        name: nameController.text,
        foodQuantityList: selectedFoodQuantityList.map((fq) => FoodQuantity(fq.food, fq.quantityAsDouble)).toList(),
      );
    }
  }

  bool _validate() {
    errorMessage = '';
    if (nameController.text.isEmpty) {
      errorMessage = 'É necessário escolher um nome para o grupo.';
      return false;
    }
    if (selectedFoodQuantityList.isEmpty) {
      errorMessage = 'É necessário adicionar algum alimento.';
      return false;
    }
    for (var fq in selectedFoodQuantityList) {
      if (fq.controller.text.isEmpty) {
        errorMessage = 'É necessário preencher a quantidade de ${fq.food.name}.';
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    for (var fq in selectedFoodQuantityList) {
      fq.controller.dispose();
    }
    super.dispose();
  }
}

class FoodQuantityHelper {
  final Food food;
  final TextEditingController controller;

  FoodQuantityHelper({
    required this.food,
    required this.controller,
  });

  double get quantityAsDouble {
    return controller.text.isNotEmpty ? double.parse(controller.text) : 0;
  }

  String get quantityAsStr {
    return controller.text;
  }
}