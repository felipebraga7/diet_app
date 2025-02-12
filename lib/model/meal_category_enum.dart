import 'package:flutter/material.dart';

enum MealCategoryEnum {
  cafeDaManha(name: "Café da manhã", icon: Icons.coffee, color: Color(0xffEC9C6A)),
  lancheDaManha(name: "Lanche da manhã", icon: Icons.breakfast_dining, color: Color(0xff4FD1C5)),
  almoco(name: "Almoço", icon: Icons.brunch_dining, color: Color(0xffd92739)),
  lancheDaTarde(name: "Lanche da tarde", icon: Icons.breakfast_dining, color: Color(0xffcf791d)),
  jantar(name: "Jantar", icon: Icons.takeout_dining, color: Color(0xff63B3ED)),
  ceia(name: "Ceia", icon: Icons.egg, color: Color(0xff9B6BCE));

  final String name;
  final IconData icon;
  final Color color;

  const MealCategoryEnum({
    required this.name,
    required this.icon,
    required this.color,
  });
}
