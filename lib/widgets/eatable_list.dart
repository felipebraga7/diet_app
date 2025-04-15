import 'package:diet_app/controller/eatable_list_controller.dart';
import 'package:diet_app/model/eatable.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_input_field.dart';

class EatableList extends StatelessWidget {
  final bool showFoods;
  final bool showFoodGroups;
  final void Function(Eatable eatable)? onEatableSelect;

  const EatableList({this.showFoods = true, this.showFoodGroups = true, this.onEatableSelect, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    Get.delete<EatableListController>();
    return GetBuilder<EatableListController>(
        init: EatableListController(showFoods: showFoods, showFoodGroups: showFoodGroups),
        builder: (c) {
          return !c.eatablesLoaded
              ? CircularProgressIndicator()
              : Scaffold(
                  body: Column(children: [
                    SearchInputField(hint: 'Procure por um alimento', onText: (text) => c.search(text)),
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
                              onTap: () {
                                if (onEatableSelect != null) {
                                  onEatableSelect!(c.filteredEatableList[index]);
                                } else {
                                  c.onEatableSelect(c.filteredEatableList[index]);
                                }
                              });
                        },
                      ),
                    )
                  ]),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => c.addEatable(),
                    tooltip: 'Adicionar',
                    backgroundColor: colorScheme.primary,
                    child: Icon(Icons.add), // Tooltip text when long-pressed
                  ));
        });
  }
}
