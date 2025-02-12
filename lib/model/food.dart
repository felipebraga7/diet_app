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
}
