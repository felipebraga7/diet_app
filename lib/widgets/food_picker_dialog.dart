import 'package:diet_app/widgets/eatable_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EatablePickerDialog extends StatelessWidget {
  const EatablePickerDialog({this.showFoods = true, this.showFoodGroups = true, super.key});

  final bool showFoods;
  final bool showFoodGroups;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: EatableList(showFoods: showFoods, showFoodGroups: showFoodGroups, onEatableSelect: (eatableSelected) => Get.back(result: eatableSelected),),
      ),
    );
  }
}
