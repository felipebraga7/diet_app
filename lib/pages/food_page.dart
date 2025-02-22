import 'package:diet_app/controller/food_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/pages/create_food_page.dart';
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
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                    child: SearchInputField(hint: 'Procure por um alimento', onText: (text) => c.search(text)),
                  ),
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
                                  _getSubtitle(c.filteredFoodList[index]),
                                  style: textTheme.labelLarge,
                                ),
                                SimpleDivider()
                              ],
                            ),
                            onTap: () => Get.to(
                              () => CreateUpdateFoodPage(
                                food: c.filteredFoodList[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ]);
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(
              () => CreateUpdateFoodPage(),
            ),
            tooltip: 'Adicionar',
            backgroundColor: colorScheme.primary,
            child: Icon(Icons.add), // Tooltip text when long-pressed
          )),
    );
  }

  String _getSubtitle(Food food) {
    return '${food.getPortionCalories()} cal '
        '| ${food.getPortionCarbs()}C '
        '| ${food.getPortionCarbs()}P '
        '| ${food.getPortionFat()}G '
        '• ${food.standardQuantity.toStringAsFixed(0)}g';
  }
}
