import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/meal.dart';
import 'package:diet_app/widgets/food_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/food_controller.dart';
import '../model/food.dart';
import '../util/utils.dart';

class AddEditMealDialog extends StatelessWidget {
  final Meal meal;

  const AddEditMealDialog({required this.meal, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: GetBuilder<FoodController>(
            init: FoodController(),
            builder: (c) {
              return !c.foodsLoaded
                  ? CircularProgressIndicator()
                  : Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Food? selectedFood = await showDialog(
                              context: context,
                              builder: (context) {
                                return FoodPickerDialog();
                              },
                            );
                            if (selectedFood != null) {
                              c.setSelectedFood(selectedFood);
                            }
                          },
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child:
                                Text(c.selectedFood == null ? 'Selecione um alimento' : c.selectedFood!.name,
                                  style: textTheme.labelLarge,)),
                                IconTheme(
                                  data: IconThemeData(
                                    color: colorScheme.primary,
                                    size: 24,
                                  ),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: c.weightController,
                                style: textTheme.bodySmall,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  labelText: 'Peso (g)',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNutrientColumn(context, 'Kcal.', c.selectedFood?.caloriesPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn(context, 'Prot.', c.selectedFood?.proteinPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn(context, 'Carb.', c.selectedFood?.carbsPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn(context, 'Gord.', c.selectedFood?.fatPerUnit ?? 0, c.weightController.text),
                          ],
                        ),
                        ElevatedButton.icon(
                          label: Text("Adicionar"),
                          onPressed: () {
                            c.addEatEventToMeal(meal.id);
                            Get.find<MealController>().update();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.add),
                        )
                      ],
                    );
            }),
      ),
    );
  }

  Widget _buildNutrientColumn(BuildContext context, String label, double nutrientValue, String weightText) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(label,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center),
        Text(Utils.formatNumber(nutrientValue * (double.tryParse(weightText) ?? 0)),
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center),
      ],
    );
  }
}
