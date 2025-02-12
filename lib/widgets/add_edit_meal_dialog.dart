import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/meal.dart';
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
                        DropdownButton<Food>(
                          hint: Text('Selecione um alimento'),
                          value: c.selectedFood,
                          isExpanded: true,
                          onChanged: (Food? value) {
                            c.setSelectedFood(value);},
                          items: c.foods.map((food) {
                            return DropdownMenuItem(
                              value: food,
                              child: Text(food.name),
                            );
                          }).toList(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: c.weightController,
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
                            _buildNutrientColumn('Kcal.', c.selectedFood?.caloriesPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn('Prot.', c.selectedFood?.proteinPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn('Carb.', c.selectedFood?.carbsPerUnit ?? 0, c.weightController.text),
                            _buildNutrientColumn('Gord.', c.selectedFood?.fatPerUnit ?? 0, c.weightController.text),
                          ],
                        ),
                        ElevatedButton.icon(
                          label: Text("Adicionar"),
                          onPressed: () {
                            c.addFoodEventToMeal(meal.id);
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

  Widget _buildNutrientColumn(String label, double nutrientValue, String weightText) {
    return Column(
      children: [
        Text(label, textAlign: TextAlign.center),
        Text(Utils.formatNumber(nutrientValue * (double.tryParse(weightText) ?? 0)), textAlign: TextAlign.center),
      ],
    );
  }
}
