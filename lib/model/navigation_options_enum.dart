import 'package:diet_app/pages/home_page.dart';
import 'package:flutter/material.dart';

enum NavigationOptionsEnum {
  diary(formattedName: 'Diário', icon: Icons.flatware, widget: DiaryPage()),
  foods(formattedName: 'Alimentos', icon: Icons.summarize, widget: DiaryPage()),
  meals(formattedName: 'Refeições', icon: Icons.event, widget: DiaryPage()),
  menu(formattedName: 'Menu', icon: Icons.menu, widget: DiaryPage());

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
