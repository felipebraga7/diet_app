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

  Food._({
    required this.id,
    required this.name,
    required this.standardQuantity,
    required this.caloriesPerUnit,
    required this.proteinPerUnit,
    required this.carbsPerUnit,
    required this.fatPerUnit,
  });

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

  Food.empty()
      : id = Uuid().v4(),
        name = '',
        standardQuantity = 0,
        caloriesPerUnit = 0,
        proteinPerUnit = 0,
        carbsPerUnit = 0,
        fatPerUnit = 0;

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      standardQuantity: json['standardQuantity'],
      caloriesPerUnit: json['caloriesPerUnit'],
      proteinPerUnit: json['proteinPerUnit'],
      carbsPerUnit: json['carbsPerUnit'],
      fatPerUnit: json['fatPerUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'standardQuantity': standardQuantity,
      'caloriesPerUnit': caloriesPerUnit,
      'proteinPerUnit': proteinPerUnit,
      'carbsPerUnit': carbsPerUnit,
      'fatPerUnit': fatPerUnit,
    };
  }

  Food copyWith({
    String? name,
    double? standardQuantity,
    double? caloriesPerUnit,
    double? proteinPerUnit,
    double? carbsPerUnit,
    double? fatPerUnit,
  }) {
    return Food._(
      id: id,
      name: name ?? this.name,
      standardQuantity: standardQuantity ?? this.standardQuantity,
      caloriesPerUnit: caloriesPerUnit ?? this.caloriesPerUnit,
      proteinPerUnit: proteinPerUnit ?? this.proteinPerUnit,
      carbsPerUnit: carbsPerUnit ?? this.carbsPerUnit,
      fatPerUnit: fatPerUnit ?? this.fatPerUnit,
    );
  }
}
