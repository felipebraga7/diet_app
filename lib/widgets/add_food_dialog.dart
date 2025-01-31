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


final List<Food> foods = [
  Food(name: 'Chicken Breast', weight: 200, calories: 1.65, protein: 0.31, carbs: 0.0, fat: 0.035, date: null),
  Food(name: 'Egg', weight: 50, calories: 1.4, protein: 0.12, carbs: 0.012, fat: 0.1, date: null),
  Food(name: 'Greek Yogurt', weight: 150, calories: 0.6667, protein: 0.0667, carbs: 0.0267, fat: 0.0, date: null),
  Food(name: 'Tofu', weight: 100, calories: 0.7, protein: 0.08, carbs: 0.02, fat: 0.04, date: null),
  Food(name: 'Salmon', weight: 150, calories: 1.5333, protein: 0.1667, carbs: 0.0, fat: 0.0933, date: null),
  Food(name: 'Lentils', weight: 100, calories: 1.16, protein: 0.09, carbs: 0.2, fat: 0.003, date: null),
  Food(name: 'Cottage Cheese', weight: 150, calories: 0.8, protein: 0.1, carbs: 0.02, fat: 0.0333, date: null),
  Food(name: 'Almonds', weight: 30, calories: 5.6667, protein: 0.2, carbs: 0.2, fat: 0.5, date: null),
  Food(name: 'Beef (Sirloin)', weight: 200, calories: 2.1, protein: 0.25, carbs: 0.0, fat: 0.1, date: null),
  Food(name: 'Tuna (Canned in Water)', weight: 100, calories: 1.0, protein: 0.2, carbs: 0.0, fat: 0.01, date: null),
  Food(name: 'Chickpeas', weight: 100, calories: 1.64, protein: 0.09, carbs: 0.27, fat: 0.026, date: null),
  Food(name: 'Quinoa', weight: 100, calories: 1.2, protein: 0.04, carbs: 0.21, fat: 0.019, date: null),
  Food(name: 'Turkey Breast', weight: 150, calories: 1.0, protein: 0.2133, carbs: 0.0, fat: 0.0133, date: null),
  Food(name: 'Tempeh', weight: 100, calories: 1.95, protein: 0.2, carbs: 0.09, fat: 0.11, date: null),
  Food(name: 'Edamame', weight: 100, calories: 1.21, protein: 0.11, carbs: 0.1, fat: 0.05, date: null),
];

  @override
  void initState() {
    super.initState();
    // Initialize the state with the passed foodType
    dropdownValue = widget.currentFood;
    editMode = widget.editMode ?? false;
    weightController = TextEditingController(text: widget.currentFood?.weight.toString());
    textInputFocous = FocusNode();
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
                Expanded( //não necessariamente precisa ser um Expanded
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
                    icon: Icon(Icons.edit, color: Colors.white)
                )
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
                    date: DateTime.now(),
                  );
                  foodController.addFood(newFood);
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