import 'package:diet_app/controller/food_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateFoodController extends GetxController {
  final nameController = TextEditingController();
  final standardQuantityController = TextEditingController();
  final caloriesController = TextEditingController();
  final carbsController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();

  String errorMessage = '';

  @override
  void onInit() async {
    super.onInit();
  }

  void createFood() {
    if (_validate()) {
      var food = Food(
        name: nameController.text,
        standardQuantity: double.tryParse(standardQuantityController.text) ?? 0,
        caloriesPerUnit: double.tryParse(caloriesController.text) ?? 0,
        proteinPerUnit: double.tryParse(proteinController.text) ?? 0,
        carbsPerUnit: double.tryParse(carbsController.text) ?? 0,
        fatPerUnit: double.tryParse(fatController.text) ?? 0,
      );
      Get.put(FoodController()).createFood(food);
    }
  }

  bool _validate() {
    errorMessage = '';
    if (nameController.text.isEmpty) {
      errorMessage = 'É necessário escolher um nome para o alimento.';
      return false;
    }
    if (standardQuantityController.text.isEmpty) {
      errorMessage = 'É necessário preencher a porção padrão.';
      return false;
    }
    if (caloriesController.text.isEmpty) {
      errorMessage = 'É necessário preencher as calorias.';
      return false;
    }
    if (carbsController.text.isEmpty) {
      errorMessage = 'É necessário preencher os carboidratos.';
      return false;
    }
    if (proteinController.text.isEmpty) {
      errorMessage = 'É necessário preencher a proteína.';
      return false;
    }
    if (fatController.text.isEmpty) {
      errorMessage = 'É necessário preencher a gordura.';
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    standardQuantityController.dispose();
    caloriesController.dispose();
    carbsController.dispose();
    proteinController.dispose();
    fatController.dispose();
    super.dispose();
  }
}