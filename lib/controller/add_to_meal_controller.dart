import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/eatable.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_event.dart';
import 'package:diet_app/service/food_group_service.dart';
import 'package:diet_app/service/food_service.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddToMealController extends GetxController {
  final FoodService _foodService = FoodService();
  final FoodGroupService _foodGroupService = FoodGroupService();

  Eatable? selectedEatable;
  final weightController = TextEditingController();


  void setSelectedEatable(Eatable? eatable) {
    selectedEatable = eatable;
    weightController.text = eatable != null ? eatable.standardQuantity.toString() : '';
    update();
  }

  void addEatEventToMeal(String mealId) {
    if (selectedEatable != null) {
      final weight = double.tryParse(weightController.text) ?? 0;
      final foodEvent = EatEvent(
        eatable: selectedEatable!,
        quantity: weight,
      );
      Get.put(MealController()).addFoodToMeal(mealId, foodEvent);
    } else {
      Get.snackbar('Erro', 'Selecione um alimento');
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

}
