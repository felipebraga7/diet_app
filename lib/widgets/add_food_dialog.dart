import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../model/food.dart';
import '../util/utils.dart';
import '../controller/food_controller.dart';

class AddDialog extends StatefulWidget {
  final bool? editMode;
  final Food? currentFood;

  const AddDialog({super.key, this.editMode, this.currentFood});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late Food? dropdownValue;
  late bool editMode;
  bool showWarning = false;
  late FocusNode textInputFocous;

  final FoodController foodController = Get.put(FoodController());
  late TextEditingController weightController = TextEditingController();

  late List<Food> foods;

  @override
  void initState() {
    super.initState();
    editMode = widget.editMode ?? false;
    textInputFocous = FocusNode();
    foods = foodController.foods;

    if (editMode && widget.currentFood != null) {
      // Normalize values to prevent double multiplication
      final food = widget.currentFood!;
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
                Column(
                  children: [
                    Text('Kcal.', textAlign: TextAlign.center),
                    Text(Utils.formatNumber((dropdownValue?.calories ?? 0) * (double.tryParse(weightController.text) ?? 0)), textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  children: [
                    Text('Prot.', textAlign: TextAlign.center),
                    Text(Utils.formatNumber((dropdownValue?.protein ?? 0) * (double.tryParse(weightController.text) ?? 0)), textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  children: [
                    Text('Carb.', textAlign: TextAlign.center),
                    Text(Utils.formatNumber((dropdownValue?.carbs ?? 0) * (double.tryParse(weightController.text) ?? 0)), textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  children: [
                    Text('Gord.', textAlign: TextAlign.center),
                    Text(Utils.formatNumber((dropdownValue?.fat ?? 0) * (double.tryParse(weightController.text) ?? 0)), textAlign: TextAlign.center),
                  ],
                ),
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
                  final newFood = Food(
                    name: dropdownValue!.name,
                    weight: weight,
                    calories: dropdownValue!.calories * weight,
                    protein: dropdownValue!.protein * weight,
                    carbs: dropdownValue!.carbs * weight,
                    fat: dropdownValue!.fat * weight,
                    date: editMode ? widget.currentFood!.date : DateTime.now(),
                  );
                  editMode
                      ? foodController.updateFood(widget.currentFood!, newFood)
                      : foodController.addFood(newFood);
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
}