import 'package:diet_app/controller/food_picker_controller.dart';
import 'package:diet_app/widgets/eatable_list.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/food.dart';
import 'search_input_field.dart';

class EatablePickerDialog extends StatelessWidget {
  const EatablePickerDialog({this.showFoods = true, this.showFoodGroups = true, super.key});

  final bool showFoods;
  final bool showFoodGroups;

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.width.toString());
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: EatableList(showFoods: showFoods, showFoodGroups: showFoodGroups, onEatableSelect: (eatableSelected) => Get.back(result: eatableSelected),),
      ),
    );
  }
}
