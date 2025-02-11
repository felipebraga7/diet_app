import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/food.dart';

class FoodController extends GetxController {
  var foods = <Food>[].obs;
  var meals = <Food>[].obs;
  final Box<Food> foodBox = Hive.box<Food>('foods');
  final Box<Food> mealBox = Hive.box<Food>('meals');
  DateTime selectedDate = DateTime.now();
  Food? selectedFood;
  double calories = 0;
  double protein = 0;
  double carbs = 0;
  double fat = 0;

  @override
  void onInit() {
    super.onInit();
    loadFoods();
    loadMeals(DateTime.now());
  }

  void addMeal(Food food) {
    meals.add(food);
    mealBox.add(food);
    update();
  }

  void deleteMeal(Food food) {
    final key = mealBox.keys.firstWhere((k) => mealBox.get(k) == food, orElse: () => null);
    if (key != null) {
      mealBox.delete(key);
      meals.remove(food);
    }
    update();
  }

  void editMeal(Food oldMeal, Food newMeal) {
    final key = mealBox.keys.firstWhere((k) => mealBox.get(k) == oldMeal, orElse: () => null);
    if (key != null) {
      mealBox.put(key, newMeal);
      final index = meals.indexOf(oldMeal);
      if (index != -1) {
        meals[index] = newMeal;
        update();
      }
    }
  }

  void loadMeals(DateTime selectedDate) {
    meals.assignAll(
        mealBox.values.where((food) {
          return food.date != null &&
              food.date!.year == selectedDate.year &&
              food.date!.month == selectedDate.month &&
              food.date!.day == selectedDate.day;
        }).toList());
    update();
  }

  Future<void> loadFoods() async {
    if (foodBox.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/import_alimentos.csv';

      if (!await File(filePath).exists()) {
        await pickAndSaveCSV(filePath);
        if (!await File(filePath).exists()) {
          await copyAssetCSVToFile(filePath);
        }
      }

      final _rawData = await File(filePath).readAsString();
      List<List<dynamic>> _listData = const CsvToListConverter(fieldDelimiter: ';').convert(_rawData);

      List<Food> parsedFoods = _listData.skip(1).map((e) => Food(
        name: e[0].toString(),
        weight: double.tryParse(e[1].toString()) ?? 0,
        calories: double.tryParse(e[2].toString()) ?? 0,
        protein: double.tryParse(e[3].toString()) ?? 0,
        carbs: double.tryParse(e[4].toString()) ?? 0,
        fat: double.tryParse(e[5].toString()) ?? 0,
        date: DateTime.now(),
      )).toList();
      parsedFoods.sort((a, b) => a.name.compareTo(b.name));
      foodBox.addAll(parsedFoods);
    }
    foods.assignAll(foodBox.values);
    update();
  }

  Future<void> copyAssetCSVToFile(String filePath) async {
    final byteData = await rootBundle.load('assets/import_alimentos.csv');
    final buffer = byteData.buffer;
    await File(filePath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
  }

  Future<void> pickAndSaveCSV(String filePath) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      await file.copy(filePath);
    }
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    loadMeals(date);
  }
}