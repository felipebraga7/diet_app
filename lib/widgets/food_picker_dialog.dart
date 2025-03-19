import 'package:diet_app/controller/food_picker_controller.dart';
import 'package:diet_app/widgets/food_list.dart';
import 'package:diet_app/widgets/simple_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/food.dart';
import 'search_input_field.dart';

class FoodPickerDialog extends StatelessWidget {
  const FoodPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.width.toString());
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: FoodList(onFoodSelect: (foodSelected) => Get.back(result: foodSelected),),
      ),
    );
  }
}
