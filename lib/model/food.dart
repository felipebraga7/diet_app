import 'package:uuid/uuid.dart';

class Food {
  late final String id;
  final String name;
  final double standardQuantity;
  final double caloriesPerUnit;
  final double proteinPerUnit;
  final double carbsPerUnit;
  final double fatPerUnit;

  Food({
    required this.name,
    required this.standardQuantity,
    required this.caloriesPerUnit,
    required this.proteinPerUnit,
    required this.carbsPerUnit,
    required this.fatPerUnit,
  }) {
    id = Uuid().v4();
  }

  String getPortionCalories() {
    return (caloriesPerUnit * standardQuantity).toStringAsFixed(2);
  }

  String getPortionCarbs() {
    return (carbsPerUnit * standardQuantity).toStringAsFixed(2);
  }

  String getPortionProtein() {
    return (proteinPerUnit * standardQuantity).toStringAsFixed(2);
  }

  String getPortionFat() {
    return (fatPerUnit * standardQuantity).toStringAsFixed(2);
  }
}
