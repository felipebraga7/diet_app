import 'package:diet_app/main.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/util/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/food.dart';
import 'package:get/get.dart';
import '../controller/food_controller.dart';
import 'add_edit_meal_dialog.dart';

class MealList extends StatelessWidget {
  final List<Food> meals;

  const MealList({super.key, required this.meals});

  void _onEditPress(BuildContext context, Food food, DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (context) {
        return AddEditMealDialog(
          editMode: true,
          currentMeal: food,
          date: selectedDate,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(
      builder: (c) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                  },
                  children: const [
                    TableRow(
                      children: [
                        Text('Alimento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left),
                        Text('Peso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                        Text('Kcal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                        Text('Prot.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                        Text('Carb.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                        Text('Gord.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ),
              if (meals.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Nenhum alimento adicionado',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final food = meals[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                c.deleteMeal(meals[index]);
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                            ),
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                _onEditPress(context, meals[index], meals[index].date!);
                              },
                              icon: Icons.edit,
                              backgroundColor: Colors.blue,
                            )
                          ],
                        ),
                        child: Container(
                          color: index % 2 == 0 ? Theme.of(context).colorScheme.secondary : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                                4: FlexColumnWidth(1),
                                5: FlexColumnWidth(1),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    Text(food.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.left),
                                    Text(Utils.formatNumber(food.weight), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                                    Text(Utils.formatNumber(food.calories), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                                    Text(Utils.formatNumber(food.protein), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                                    Text(Utils.formatNumber(food.carbs), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                                    Text(Utils.formatNumber(food.fat), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}