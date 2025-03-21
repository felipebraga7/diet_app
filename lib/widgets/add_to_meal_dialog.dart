import 'package:diet_app/controller/add_to_meal_controller.dart';
import 'package:diet_app/model/eatable.dart';
import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/model/meal.dart';
import 'package:diet_app/widgets/food_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: GetBuilder<AddToMealController>(
            init: AddToMealController(),
            builder: (c) {
              return Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Eatable? selectedEatable = await showDialog(
                              context: context,
                              builder: (context) {
                                return EatablePickerDialog();
                              },
                            );
                            if (selectedEatable != null) {
                              c.setSelectedEatable(selectedEatable);
                            }
                          },
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child:
                                Text(c.selectedEatable == null ? 'Selecione um alimento' : c.selectedEatable!.name,
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
                                  labelText: c.selectedEatable != null && c.selectedEatable is FoodGroup ? 'Unidades' : 'Peso (g)',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNutrientColumn(context, 'Kcal.', c.selectedEatable?.caloriesPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn(context, 'Prot.', c.selectedEatable?.proteinPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn(context, 'Carb.', c.selectedEatable?.carbsPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn(context, 'Gord.', c.selectedEatable?.fatPerUnit ?? 0, c.weightController.text),
                          ],
                        ),
                        ElevatedButton.icon(
                          label: Text("Adicionar"),
                          onPressed: () {
                            c.addEatEventToMeal(meal.id);
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
