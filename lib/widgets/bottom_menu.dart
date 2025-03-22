import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomMenu extends StatelessWidget {
  final NavigationOptionsEnum navigationOptionSelected;

  const BottomMenu(this.navigationOptionSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: NavigationOptionsEnum.values.map((option) {
        return BottomNavigationBarItem(
          icon: Icon(option.icon),
          label: option.formattedName,
        );
      }).toList(),
      currentIndex: navigationOptionSelected.index,
      onTap: (index) {
        if (index == navigationOptionSelected.index) return;
        _navigate(NavigationOptionsEnum.values[index].widget);
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  Future<void> _navigate(Widget page) async {
    Get.offAll(
      () => page,
      transition: Transition.noTransition,
      duration: Duration.zero,
    );
  }
}
