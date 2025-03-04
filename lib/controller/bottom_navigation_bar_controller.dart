import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  ScrollController scrollController = ScrollController();
  NavigationOptionsEnum selectedOption = NavigationOptionsEnum.diary;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void setSelectedOption(NavigationOptionsEnum currOption) {
    selectedOption = currOption;
    update();
  }

  void onItemTapped(int index) {
    selectedOption = NavigationOptionsEnum.values[index];
    update();
  }
}
