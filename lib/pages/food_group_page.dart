import 'package:diet_app/controller/food_group_controller.dart';
import 'package:diet_app/core/app_theme.dart';
import 'package:diet_app/model/food_group.dart';
import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:diet_app/pages/create_update_food_group_page.dart';
import 'package:diet_app/widgets/bottom_menu.dart';
import 'package:diet_app/widgets/eatable_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodGroupPage extends StatelessWidget {
  const FoodGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<FoodGroupController>(
              init: FoodGroupController(),
              builder: (c) {
                return !c.foodGroupsLoaded
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                        child: EatableList(showFoods: false),
                    );
              }),
          bottomNavigationBar: BottomMenu(NavigationOptionsEnum.foodGroups),
    ));
  }
}
