import 'package:diet_app/controller/food_picker_controller.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/food.dart';
import 'search_input_field.dart';
// TODO: transformar em eatable list, carregar todos os eatables e usar em food group page
class FoodList extends StatelessWidget {
  final void Function(Food food) onFoodSelect;

  const FoodList({required this.onFoodSelect, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GetBuilder<FoodListController>(
        init: FoodListController(),
        builder: (c) {
          return !c.foodsLoaded
              ? CircularProgressIndicator()
              : Column(children: [
                  SearchInputField(
                      hint: 'Procure por um alimento',
                      onText: (text) => c.search(text)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: c.filteredFoodList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.filteredFoodList[index].name,
                                style: textTheme.titleSmall,
                              ),
                              Text(
                                c.filteredFoodList[index].nutritionData,
                                style: textTheme.labelMedium,
                              ),
                              SimpleDivider()
                            ],
                          ),
                          onTap: () =>
                             onFoodSelect(c.filteredFoodList[index]),
                        );
                      },
                    ),
                  )
                ]);
        });
  }
}
