import 'package:diet_app/controller/bottom_navigation_bar_controller.dart';
import 'package:diet_app/model/navigation_options_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarController>(
      builder: (c) {
        return BottomNavigationBar(
          items: NavigationOptionsEnum.values.map((option) {
            return BottomNavigationBarItem(
              icon: Icon(option.icon),
              label: option.formattedName,
            );
          }).toList(),
          currentIndex: c.selectedOption.index,
          onTap: c.onItemTapped,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        );
      },
    );
  }
}