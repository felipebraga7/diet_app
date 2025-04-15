import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:diet_app/widgets/bottom_menu.dart';
import 'package:diet_app/widgets/eatable_list.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: EatableList(showFoodGroups: false),
          ),
          bottomNavigationBar: BottomMenu(NavigationOptionsEnum.foods),
    ));
  }
}
