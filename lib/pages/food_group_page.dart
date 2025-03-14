import 'package:diet_app/controller/food_group_controller.dart';
import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/pages/create_update_food_group_page.dart';
import 'package:diet_app/widgets/search_input_field.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodGroupPage extends StatelessWidget {
  const FoodGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
          body: GetBuilder<FoodGroupController>(
              init: FoodGroupController(),
              builder: (c) {
                return !c.foodGroupsLoaded
                    ? Center(child: CircularProgressIndicator())
                    : Column(children: [
                      Padding(
                    padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                    child: SearchInputField(hint: 'Procure por um grupo de alimentos', onText: (text) => c.search(text)),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: ListView.builder(
                        itemCount: c.filteredFoodGroupList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.filteredFoodGroupList[index].name,
                                  style: textTheme.titleMedium,
                                ),
                                Text(
                                  _getSubtitle(c.filteredFoodGroupList[index]),
                                  style: textTheme.labelLarge,
                                ),
                                SimpleDivider()
                              ],
                            ),
                            onTap: () => _navigateToUpdatePage(context, c, c.filteredFoodGroupList[index]),
                          );
                        },
                      ),
                    ),
                  )
                ]);
              }),
          floatingActionButton: GetBuilder<FoodGroupController>(
            builder: (c) {
              return FloatingActionButton(
                onPressed: () => _navigateToUpdatePage(context, c, null),
                tooltip: 'Adicionar',
                backgroundColor: colorScheme.primary,
                child: Icon(Icons.add),
              );
            }
          )),
    );
  }

  String _getSubtitle(FoodGroup foodGroup) {
    return '${foodGroup.getPortionCalories()} kcal '
        '| ${foodGroup.getPortionCarbs()}C '
        '| ${foodGroup.getPortionProtein()}P '
        '| ${foodGroup.getPortionFat()}G';
  }

  _navigateToUpdatePage(BuildContext context, FoodGroupController c, FoodGroup? foodGroup) {
    final colorScheme = Theme.of(context).colorScheme;
    Get.to(() => CreateUpdateFoodGroupPage(foodGroup: foodGroup),)?.then((result) {
      if (result == null) return;
      if (result['action'] == 'delete') {
        c.deleteFoodGroup(result['food']);
      } else if (result['action'] == 'save') {
        c.saveFoodGroup(result['food']);
        Get.snackbar(
          'Sucesso!',
          'Grupo salvo com sucesso!',
          duration: Duration(seconds: 3),
          backgroundColor: colorScheme.success,
          backgroundGradient: RadialGradient(
            colors: [colorScheme.successGradientEnd, colorScheme.successGradientStart],
          ),
        );
      }
    });
  }
}
