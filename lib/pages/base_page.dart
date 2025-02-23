import 'package:diet_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_app/controller/bottom_navigation_bar_controller.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarController>(
      init: BottomNavigationBarController(),
      builder: (c) {
        return Scaffold(
          body: c.selectedOption.widget,
          bottomNavigationBar: BottomNavigationBarWidget(),
        );
      },
    );
  }
}