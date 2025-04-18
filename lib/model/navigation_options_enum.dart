import 'package:diet_app/pages/diary_page.dart';
import 'package:diet_app/pages/food_group_page.dart';
import 'package:diet_app/pages/food_page.dart';
import 'package:flutter/material.dart';

enum NavigationOptionsEnum {
  diary(formattedName: 'Diário', icon: Icons.flatware, widget: DiaryPage()),
  foods(formattedName: 'Alimentos', icon: Icons.summarize, widget: FoodPage()),
  foodGroups(formattedName: 'Grupos', icon: Icons.event, widget: FoodGroupPage());
  // menu(formattedName: 'Menu', icon: Icons.menu, widget: DiaryPage());

  const NavigationOptionsEnum({
    required this.formattedName,
    required this.icon,
    required this.widget,
  });

  final String formattedName;
  final IconData icon;
  final Widget widget;

  String toJson() => name;

  static NavigationOptionsEnum fromJson(String json) => values.byName(json);
}
