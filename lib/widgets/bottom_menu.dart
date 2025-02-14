import 'package:diet_app/controller/bottom_menu_controller.dart';
import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> with SingleTickerProviderStateMixin {
  bool hide = false;

  @override
  void initState() {
    super.initState();
    var bottomMenuController = Get.put(BottomMenuController());
    bottomMenuController.scrollController.addListener(() {
      bool isForward = bottomMenuController.scrollController.position.userScrollDirection == ScrollDirection.forward;
      if (!isForward && !hide || isForward && hide) {
        setState(() {
          hide = !hide;
        });
      }
    });
  }

  @override
  void dispose() {
    Get.delete<BottomMenuController>();
    super.dispose();
  }

  double _getTop() {
    return hide ? (Get.height + 55) : (Get.height - Get.bottomBarHeight - 55 - 14);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<BottomMenuController>(
        init: BottomMenuController(),
        builder: (c) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutSine,
                top: _getTop(),
                left: 14,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          height: 55,
                          width: Get.width - 28,
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
                          )),
                    ),
                    Positioned(
                      top: -27,
                      left: (Get.width - 28) / 2 - 27,
                      child: SizedBox(
                          height: 54,
                          width: 54,
                          child: FloatingActionButton(
                              backgroundColor: colorScheme.surface,
                              elevation: 0,
                              onPressed: () => debugPrint("add foodevent clicked"),
                              shape: RoundedRectangleBorder(side: BorderSide(width: 3, color: colorScheme.primary), borderRadius: BorderRadius.circular(100)),
                              child: Icon(Icons.add, color: colorScheme.primary))),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
