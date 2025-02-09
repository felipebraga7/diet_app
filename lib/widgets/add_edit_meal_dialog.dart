import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../model/food.dart';
import '../util/utils.dart';
import '../controller/food_controller.dart';

class AddEditMealDialog extends StatefulWidget {
  final bool? editMode;
  final Food? currentMeal;
  final DateTime date;

  const AddEditMealDialog({super.key, this.editMode, this.currentMeal, required this.date});

  @override
  State<AddEditMealDialog> createState() => _AddEditMealDialogState();
}

class _AddEditMealDialogState extends State<AddEditMealDialog> {
  late Food? dropdownValue;
  late bool editMode;
  bool showWarning = false;
  late FocusNode textInputFocous;

  final FoodController c = Get.put(FoodController());
  late TextEditingController weightController = TextEditingController();

  late List<Food> foods;

  @override
  void initState() {
    super.initState();
    editMode = widget.editMode ?? false;
    textInputFocous = FocusNode();
    foods = c.foods;

    if (editMode && widget.currentMeal != null) {
      // Normalize values to prevent double multiplication
      final food = widget.currentMeal!;
      dropdownValue = Food(
        name: food.name,
        weight: food.weight,
        calories: food.calories / food.weight,
        protein: food.protein / food.weight,
        carbs: food.carbs / food.weight,
        fat: food.fat / food.weight,
        date: food.date,
      );
      weightController = TextEditingController(text: food.weight.toString());
    } else {
      dropdownValue = null;
      weightController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: customSwatch.shade300,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<Food>(
              hint: Text('Selecione um alimento', style: TextStyle(color: Colors.white)),
              iconEnabledColor: Colors.white,
              dropdownColor: customSwatch.shade300,
              value: foods.firstWhereOrNull((element) => element.name == dropdownValue?.name),
              isExpanded: true,
              onChanged: (Food? value) {
                setState(() {
                  dropdownValue = value;
                  weightController.text = value?.weight.toString() ?? '';
                  showWarning = false;
                });
              },
              items: foods.map((food) {
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
                    controller: weightController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    focusNode: textInputFocous,
                    decoration: InputDecoration(
                      labelText: 'Peso (g)',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                    onPressed: textInputFocous.requestFocus,
                    icon: Icon(Icons.edit, color: Colors.white))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutrientColumn('Kcal.', dropdownValue?.calories ?? 0, weightController.text),
                _buildNutrientColumn('Prot.', dropdownValue?.protein ?? 0, weightController.text),
                _buildNutrientColumn('Carb.', dropdownValue?.carbs ?? 0, weightController.text),
                _buildNutrientColumn('Gord.', dropdownValue?.fat ?? 0, weightController.text),
              ],
            ),
            if (showWarning)
              Text(
                'Nenhum alimento selecionado',
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton.icon(
              label: Text(editMode ? "Editar" : "Adicionar"),
              onPressed: () {
                if (dropdownValue != null) {
                  final weight = double.tryParse(weightController.text) ?? 0;
                  final newMeal = Food(
                    name: dropdownValue!.name,
                    weight: weight,
                    calories: dropdownValue!.calories * weight,
                    protein: dropdownValue!.protein * weight,
                    carbs: dropdownValue!.carbs * weight,
                    fat: dropdownValue!.fat * weight,
                    date: editMode ? widget.currentMeal!.date : widget.date,
                  );
                  editMode
                      ? c.editMeal(widget.currentMeal!, newMeal)
                      : c.addMeal(newMeal);
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    showWarning = true;
                  });
                }
              },
              icon: Icon(editMode ? Icons.edit : Icons.add),
            )
          ],
        ),
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