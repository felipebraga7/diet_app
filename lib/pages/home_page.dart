import 'package:diet_app/main.dart';
import 'package:diet_app/widgets/add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/calendar_selector.dart';
import '../widgets/diet_list.dart';
import '../widgets/diet_summary.dart';
import '../model/food.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('mybox');
  DateTime _selectedDate = DateTime.now();

  // Callback to handle date selection
  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onAddPress() {
    showDialog(
      context: context, 
      builder: (context) {
        return AddDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Food> foods = [
      Food(name: 'Chicken Breast', weight: 200, calories: 330, protein: 62, carbs: 0, fat: 7),
      Food(name: 'Egg', weight: 50, calories: 70, protein: 6, carbs: 0.6, fat: 5),
      Food(name: 'Greek Yogurt', weight: 150, calories: 100, protein: 10, carbs: 4, fat: 0),
      Food(name: 'Tofu', weight: 100, calories: 70, protein: 8, carbs: 2, fat: 4),
      Food(name: 'Salmon', weight: 150, calories: 230, protein: 25, carbs: 0, fat: 14),
      Food(name: 'Lentils', weight: 100, calories: 116, protein: 9, carbs: 20, fat: 0.3),
      Food(name: 'Cottage Cheese', weight: 150, calories: 120, protein: 15, carbs: 3, fat: 5),
      Food(name: 'Almonds', weight: 30, calories: 170, protein: 6, carbs: 6, fat: 15),
      Food(name: 'Beef (Sirloin)', weight: 200, calories: 420, protein: 50, carbs: 0, fat: 20),
      Food(name: 'Tuna (Canned in Water)', weight: 100, calories: 100, protein: 20, carbs: 0, fat: 1),
      Food(name: 'Chickpeas', weight: 100, calories: 164, protein: 9, carbs: 27, fat: 2.6),
      Food(name: 'Quinoa', weight: 100, calories: 120, protein: 4, carbs: 21, fat: 1.9),
      Food(name: 'Turkey Breast', weight: 150, calories: 150, protein: 32, carbs: 0, fat: 2),
      Food(name: 'Tempeh', weight: 100, calories: 195, protein: 20, carbs: 9, fat: 11),
      Food(name: 'Edamame', weight: 100, calories: 121, protein: 11, carbs: 10, fat: 5),
    ];

    return Scaffold(
      backgroundColor: customSwatch.shade100,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPress,
        child: Icon(Icons.add),  
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              // Calendar Selector
              CalendarSelector(
                onDateSelected: _onDateSelected,
                initialSelectedDate: _selectedDate,
              ),
              // Diet Summary
              DietSummary(foods: foods),
              // Diet List
              DietList(foods: foods),
            ],
          ),
      ),
      );
  }
}