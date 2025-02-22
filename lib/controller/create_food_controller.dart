import 'package:diet_app/controller/food_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateUpdateFoodController extends GetxController {
  Food food;

  final nameController = TextEditingController();
  final standardQuantityController = TextEditingController();
  final caloriesController = TextEditingController();
  final carbsController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();

  String errorMessage = '';

  CreateUpdateFoodController({
    required this.food,
  });

  @override
  void onInit() async {
    nameController.text = food.name;
    standardQuantityController.text = food.standardQuantity > 0 ? food.standardQuantity.toString() : '';
    caloriesController.text = food.caloriesPerUnit > 0 ? (food.caloriesPerUnit*food.standardQuantity).toString(): '';
    carbsController.text = food.carbsPerUnit > 0 ? (food.carbsPerUnit*food.standardQuantity).toString(): '';
    proteinController.text = food.proteinPerUnit > 0 ? (food.proteinPerUnit*food.standardQuantity).toString(): '';
    fatController.text = food.fatPerUnit > 0 ? (food.fatPerUnit*food.standardQuantity).toString(): '';
    super.onInit();
  }

  void saveFood() {
    if (_validate()) {
      var standardQuantity = double.tryParse(standardQuantityController.text) ?? 0;
      food = food.copyWith(
        name: nameController.text,
        standardQuantity: standardQuantity,
        caloriesPerUnit: Utils.round(double.tryParse(caloriesController.text)! / standardQuantity, 5),
        proteinPerUnit: Utils.round(double.tryParse(proteinController.text)! / standardQuantity, 5),
        carbsPerUnit: Utils.round(double.tryParse(carbsController.text)! / standardQuantity, 5),
        fatPerUnit: Utils.round(double.tryParse(fatController.text)! / standardQuantity, 5),
      );
      Get.put(FoodController()).createUpdateFood(food);
    }
  }

  bool _validate() {
    errorMessage = '';
    if (nameController.text.isEmpty) {
      errorMessage = 'É necessário escolher um nome para o alimento.';
      return false;
    }
    if (standardQuantityController.text.isEmpty || double.tryParse(standardQuantityController.text)! < 0) {
      errorMessage = 'É necessário preencher a porção padrão.';
      return false;
    }
    if (caloriesController.text.isEmpty || double.tryParse(caloriesController.text)! < 0) {
      errorMessage = 'É necessário preencher as calorias.';
      return false;
    }
    if (carbsController.text.isEmpty || double.tryParse(carbsController.text)! < 0) {
      errorMessage = 'É necessário preencher os carboidratos.';
      return false;
    }
    if (proteinController.text.isEmpty || double.tryParse(proteinController.text)! < 0) {
      errorMessage = 'É necessário preencher a proteína.';
      return false;
    }
    if (fatController.text.isEmpty || double.tryParse(fatController.text)! < 0) {
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