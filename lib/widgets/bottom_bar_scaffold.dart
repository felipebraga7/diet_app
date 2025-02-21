import 'package:diet_app/controller/bottom_menu_controller.dart';
import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:diet_app/pages/choose_meal_bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BottomBarScaffold extends StatelessWidget {
  final Widget body;

  const BottomBarScaffold({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
          height: 54,
          width: 54,
          child: FloatingActionButton(
              backgroundColor: colorScheme.surface,
              elevation: 0,
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ChooseMealBottomDialog();
                  }),
              shape: RoundedRectangleBorder(side: BorderSide(width: 3, color: colorScheme.primary), borderRadius: BorderRadius.circular(100)),
              child: Icon(Icons.add, color: colorScheme.primary))),
      bottomNavigationBar: GetBuilder<BottomBarController>(
          init: BottomBarController(),
          builder: (c) {
            return Container(
                height: 55,
                width: Get.width,
                color: colorScheme.primary,
                child: Row(
                  children: List.generate(NavigationOptionsEnum.values.length + 1, (i) {
                    var index = i > 2 ? (i - 1) : i;
                    var currOption = NavigationOptionsEnum.values[index];
                    return i == 2
                        ? SizedBox(width: 50)
                        : Expanded(
                            child: InkWell(
                                onTap: () {
                                  c.setSelectedOption(currOption);
                                },
                                child: Icon(currOption.icon,
                                    size: c.selectedOption == currOption ? 32 : 26,
                                    color: c.selectedOption == currOption ? colorScheme.onPrimary : colorScheme.secondary)));
                  }),
                ));
          }),
    );
  }
}
