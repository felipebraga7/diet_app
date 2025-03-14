import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  NavigationOptionsEnum selectedOption = NavigationOptionsEnum.diary;

  void setSelectedOption(NavigationOptionsEnum currOption) {
    selectedOption = currOption;
    update();
  }

  void onItemTapped(int index) {
    selectedOption = NavigationOptionsEnum.values[index];
    update();
  }
}
