import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../model/food.dart';
import '../util/utils.dart';
import '../controller/food_controller.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final FoodController foodController = Get.put(FoodController());
  final TextEditingController weightController = TextEditingController();

  final List<Food> foods = [
    Food(name: 'Chicken Breast', weight: 200, calories: 330, protein: 62, carbs: 0, fat: 7, date: null),
    Food(name: 'Egg', weight: 50, calories: 70, protein: 6, carbs: 0.6, fat: 5, date: null),
    Food(name: 'Greek Yogurt', weight: 150, calories: 100, protein: 10, carbs: 4, fat: 0, date: null),
    Food(name: 'Tofu', weight: 100, calories: 70, protein: 8, carbs: 2, fat: 4, date: null),
    Food(name: 'Salmon', weight: 150, calories: 230, protein: 25, carbs: 0, fat: 14, date: null),
    Food(name: 'Lentils', weight: 100, calories: 116, protein: 9, carbs: 20, fat: 0.3, date: null),
    Food(name: 'Cottage Cheese', weight: 150, calories: 120, protein: 15, carbs: 3, fat: 5, date: null),
    Food(name: 'Almonds', weight: 30, calories: 170, protein: 6, carbs: 6, fat: 15, date: null),
    Food(name: 'Beef (Sirloin)', weight: 200, calories: 420, protein: 50, carbs: 0, fat: 20, date: null),
    Food(name: 'Tuna (Canned in Water)', weight: 100, calories: 100, protein: 20, carbs: 0, fat: 1, date: null),
    Food(name: 'Chickpeas', weight: 100, calories: 164, protein: 9, carbs: 27, fat: 2.6, date: null),
    Food(name: 'Quinoa', weight: 100, calories: 120, protein: 4, carbs: 21, fat: 1.9, date: null),
    Food(name: 'Turkey Breast', weight: 150, calories: 150, protein: 32, carbs: 0, fat: 2, date: null),
    Food(name: 'Tempeh', weight: 100, calories: 195, protein: 20, carbs: 9, fat: 11, date: null),
    Food(name: 'Edamame', weight: 100, calories: 121, protein: 11, carbs: 10, fat: 5, date: null),
  ];
  Food? dropdownValue = null;
  bool showWarning = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: customSwatch.shade300,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownMenu(
              label: Text("Alimento"),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.white),
                suffixIconColor: Colors.white,
              ),
              expandedInsets: EdgeInsets.all(0),
              onSelected: (Food? value) {
                setState(() {
                  dropdownValue = value;
                  weightController.text = value?.weight.toString() ?? '';
                });
              },
              dropdownMenuEntries: foods.map<DropdownMenuEntry<Food>>((Food value) {
                return DropdownMenuEntry<Food>(value: value, label: value.name);
              }).toList(),
            ),
            Row(
              children: [
                Expanded( //não necessariamente precisa ser um Expanded
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
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
                    onPressed: () {},
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
              label: Text("Adicionar"),
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
              icon: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}