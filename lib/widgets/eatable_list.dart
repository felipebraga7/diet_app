import 'package:diet_app/controller/eatable_list_controller.dart';
import 'package:diet_app/model/eatable.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_input_field.dart';

class EatableList extends StatelessWidget {
  final void Function(Eatable eatable) onEatableSelect;
  final bool showFoods;
  final bool showFoodGroups;

  const EatableList({required this.onEatableSelect, this.showFoods = true, this.showFoodGroups = true, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    Get.delete<EatableListController>();
    return GetBuilder<EatableListController>(
        init: EatableListController(showFoods: showFoods, showFoodGroups: showFoodGroups),
        builder: (c) {
          return !c.eatablesLoaded
              ? CircularProgressIndicator()
              : Column(children: [
                  SearchInputField(
                      hint: 'Procure por um alimento',
                      onText: (text) => c.search(text)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: c.filteredEatableList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.filteredEatableList[index].name,
                                style: textTheme.titleSmall,
                              ),
                              Text(
                                c.filteredEatableList[index].nutritionData,
                                style: textTheme.labelMedium,
                              ),
                              SimpleDivider()
                            ],
                          ),
                          onTap: () =>
                             onEatableSelect(c.filteredEatableList[index]),
                        );
                      },
                    ),
                  )
                ]);
        });
  }
}
