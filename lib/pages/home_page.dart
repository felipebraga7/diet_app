import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../widgets/add_edit_meal_dialog.dart';
import '../widgets/calendar_selector.dart';
import '../widgets/meal_list.dart';
import '../widgets/meal_summary.dart';
import '../controller/food_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final FoodController foodController = Get.put(FoodController());

  void _onAddPress() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return GetBuilder<FoodController>(
          builder: (c) {
            return AddEditMealDialog(
              editMode: false,
              date: c.selectedDate,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customSwatch.shade100,
      appBar: AppBar(
        title: Text('Diet App'),
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
            GetBuilder<FoodController>(
              builder: (c) => CalendarSelector(
                onDateSelected: (date) => c.updateSelectedDate(date),
              ),
            ),
            GetBuilder<FoodController>(
              builder: (c) => MealSummary(meals: c.meals),
            ),
            GetBuilder<FoodController>(
              builder: (c) => MealList(meals: c.meals),
            ),
          ],
        ),
      ),
    );
  }
}