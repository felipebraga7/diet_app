import 'package:diet_app/controller/food_controller.dart';
import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/pages/create_update_food_page.dart';
import 'package:diet_app/widgets/food_list.dart';
import 'package:diet_app/widgets/search_input_field.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: FoodList(onFoodSelect: (selectedFood) => _navigateToUpdatePage(context, selectedFood)),
          ),
          floatingActionButton: GetBuilder<FoodController>(
            init: FoodController(),
            builder: (c) {
              return FloatingActionButton(
                onPressed: () => _navigateToUpdatePage(context, null),
                tooltip: 'Adicionar',
                backgroundColor: colorScheme.primary,
                child: Icon(Icons.add), // Tooltip text when long-pressed
              );
            }
          )),
    );
  }

  _navigateToUpdatePage(BuildContext context, Food? food) {
    final colorScheme = Theme.of(context).colorScheme;
    Get.to(() => CreateUpdateFoodPage(food: food),)?.then((result) {
      if (result == null) return;
      if (result['action'] == 'delete') {
        Get.put(FoodController()).deleteFood(result['food']);
      } else if (result['action'] == 'save') {
        Get.put(FoodController()).saveFood(result['food']);
        Get.snackbar(
          'Sucesso!',
          'Alimento salvo com sucesso!',
          duration: Duration(seconds: 3),
          backgroundColor: colorScheme.success,
          backgroundGradient: RadialGradient(
            colors: [colorScheme.successGradientEnd, colorScheme.successGradientStart],
          ),
        );
      }
    });
  }
}
