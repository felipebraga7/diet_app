import 'package:diet_app/main.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/util/utils.dart';
import '../model/food.dart';

class DietList extends StatefulWidget {
  final List<Food> foods;
  final DateTime selectedDate;

  const DietList({super.key, required this.foods, required this.selectedDate});

  @override
  _DietListState createState() => _DietListState();
}

class _DietListState extends State<DietList> {
  @override
  Widget build(BuildContext context) {
    final filteredFoods = widget.foods.where((food) {
      return food.date != null &&
          food.date!.year == widget.selectedDate.year &&
          food.date!.month == widget.selectedDate.month &&
          food.date!.day == widget.selectedDate.day;
    }).toList();

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
          Expanded(
            child: ListView.builder(
              itemCount: filteredFoods.length,
              itemBuilder: (context, index) {
                final food = filteredFoods[index];
                return Container(
                  color: index % 2 == 0 ? customSwatch.shade300 : customSwatch.shade200,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}