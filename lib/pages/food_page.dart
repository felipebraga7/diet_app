import 'package:diet_app/controller/food_controller.dart';
import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/pages/create_update_food_page.dart';
import 'package:diet_app/widgets/search_input_field.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
          body: GetBuilder<FoodController>(
              init: FoodController(),
              builder: (c) {
                return !c.foodsLoaded
                    ? CircularProgressIndicator()
                    : Column(children: [
                        Padding(
                    padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                    child: SearchInputField(hint: 'Procure por um alimento', onText: (text) => c.search(text)),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: ListView.builder(
                        itemCount: c.filteredFoodList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.filteredFoodList[index].name,
                                  style: textTheme.titleMedium,
                                ),
                                Text(
                                  c.filteredFoodList[index].nutritionData,
                                  style: textTheme.labelLarge,
                                ),
                                SimpleDivider()
                              ],
                            ),
                            onTap: () => _navigateToUpdatePage(context, c, c.filteredFoodList[index]),
                          );
                        },
                      ),
                    ),
                  )
                ]);
              }),
          floatingActionButton: GetBuilder<FoodController>(
            builder: (c) {
              return FloatingActionButton(
                onPressed: () => _navigateToUpdatePage(context, c, null),
                tooltip: 'Adicionar',
                backgroundColor: colorScheme.primary,
                child: Icon(Icons.add), // Tooltip text when long-pressed
              );
            }
          )),
    );
  }

  _navigateToUpdatePage(BuildContext context, FoodController c, Food? food) {
    final colorScheme = Theme.of(context).colorScheme;
    Get.to(() => CreateUpdateFoodPage(food: food),)?.then((result) {
      if (result == null) return;
      if (result['action'] == 'delete') {
        c.deleteFood(result['food']);
      } else if (result['action'] == 'save') {
        c.saveFood(result['food']);
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
