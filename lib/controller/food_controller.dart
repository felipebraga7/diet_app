import 'package:csv/csv.dart';
import 'package:diet_app/controller/meal_controller.dart';
import 'package:diet_app/model/food.dart';
import 'package:diet_app/model/food_event.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final List<Food> foodList = [];
  List<Food> filteredFoodList = [];
  Food? selectedFood;
  bool foodsLoaded = false;
  final weightController = TextEditingController();
  final searchTextController = TextEditingController();
  String? searchText;

  @override
  void onInit() async {
    _loadFoods();
    super.onInit();
  }

  void _loadFoods() async {
    if (foodList.isEmpty) {
      final rawData = await rootBundle.loadString("assets/comidasv1.csv");
      List<List<dynamic>> listData = const CsvToListConverter(
          fieldDelimiter: ';').convert(rawData);

      List<Food> parsedFoods = listData.skip(1).map((e) =>
          Food(
            name: e[0].toString(),
            standardQuantity: double.tryParse(e[1].toString()) ?? 0,
            caloriesPerUnit: double.tryParse(e[2].toString()) ?? 0,
            proteinPerUnit: double.tryParse(e[3].toString()) ?? 0,
            carbsPerUnit: double.tryParse(e[4].toString()) ?? 0,
            fatPerUnit: double.tryParse(e[5].toString()) ?? 0,
          )).toList();
      parsedFoods.sort((a, b) => a.name.compareTo(b.name));
      foodList.addAll(parsedFoods);
      filteredFoodList.addAll(parsedFoods);
    }
    foodsLoaded = true;
    update();
  }

  void setSelectedFood(Food? food) {
    selectedFood = food;
    weightController.text = food != null ? food.standardQuantity.toString() : '';
    update();
  }

  void addFoodEventToMeal(String mealId) {
    if (selectedFood != null) {
      final weight = double.tryParse(weightController.text) ?? 0;
      final foodEvent = FoodEvent(
        food: selectedFood!,
        quantity: weight,
      );
      Get.put(MealController()).addFoodToMeal(mealId, foodEvent);
    } else {
      Get.snackbar('Erro', 'Selecione um alimento');
    }
  }

  Future<void> search(String text) async {
    searchText = text;
    searchTextController.value = TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
    if (searchText != null && searchText!.isNotEmpty) {
      filteredFoodList = foodList.where((food) => replaceDiacritics(food.name.toLowerCase()).contains(replaceDiacritics(text.toLowerCase()))).toList();
    } else {
      filteredFoodList = foodList;
    }
    update();
  }

  void createFood(Food food) {
    foodList.add(food);
  }

  void cleanSearch() {
    searchTextController.value = TextEditingValue(
      text: '',
      selection: TextSelection.fromPosition(
        const TextPosition(offset: 0),
      ),
    );
  }

  String replaceDiacritics(String str) {
    var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  @override
  void dispose() {
    weightController.dispose();
    searchTextController.dispose();
    super.dispose();
  }
}