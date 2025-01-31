import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../widgets/add_food_dialog.dart';
import '../widgets/calendar_selector.dart';
import '../widgets/diet_list.dart';
import '../widgets/diet_summary.dart';
import '../controller/food_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FoodController foodController = Get.put(FoodController());
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onAddPress() {
    showDialog(
      context: context, 
      builder: (context) {
        return AddDialog(editMode: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Obx(() => DietSummary(
                foods: foodController.foods.isNotEmpty
                    ? foodController.foods
                    : [],
                selectedDate: _selectedDate,
              )),
              // Diet List
              Obx(() => DietList(
                foods: foodController.foods.isNotEmpty
                    ? foodController.foods
                    : [],
                selectedDate: _selectedDate,
              )),
            ],
          ),
      ),
    );
  }
}