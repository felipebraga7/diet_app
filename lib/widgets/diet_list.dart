import 'package:flutter/material.dart';
import '../model/food.dart';

class DietList extends StatefulWidget {
  final List<Food> foods;

  const DietList({super.key, required this.foods});

  @override
  _DietListState createState() => _DietListState();
}

class _DietListState extends State<DietList> {
  String formatNumber(double number) {
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
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
                    Text('Prot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    Text('Carb', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    Text('Gord', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              elevation: 8,
              child: ListView.builder(
                itemCount: widget.foods.length,
                itemBuilder: (context, index) {
                  final food = widget.foods[index];
                  return Container(
                    color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
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
                              Text(food.name, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.left),
                              Text(formatNumber(food.weight), style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                              Text(formatNumber(food.calories), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                              Text(formatNumber(food.protein), style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                              Text(formatNumber(food.carbs), style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                              Text(formatNumber(food.fat), style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}