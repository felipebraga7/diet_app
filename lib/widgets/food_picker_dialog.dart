import 'package:diet_app/controller/food_picker_controller.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/food.dart';
import 'search_input_field.dart';

class FoodPickerDialog extends StatelessWidget {
  const FoodPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: GetBuilder<FoodPickerController>(
            init: FoodPickerController(),
            builder: (c) {
              return !c.foodsLoaded
                  ? CircularProgressIndicator()
                  : Column(children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 14, left: 14, right: 14),
                        child: SearchInputField(
                            hint: 'Procure por um alimento',
                            onText: (text) => c.search(text)),
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
                                      _getSubtitle(c.filteredFoodList[index]),
                                      style: textTheme.labelLarge,
                                    ),
                                    SimpleDivider()
                                  ],
                                ),
                                onTap: () =>
                                    Get.back(result: c.filteredFoodList[index]),
                              );
                            },
                          ),
                        ),
                      )
                    ]);
            }),
      ),
    );
  }

  String _getSubtitle(Food food) {
    return '${food.getPortionCalories()} kcal '
        '| ${food.getPortionCarbs()}C '
        '| ${food.getPortionProtein()}P '
        '| ${food.getPortionFat()}G '
        '• ${food.standardQuantity.toStringAsFixed(0)}g';
  }
}
