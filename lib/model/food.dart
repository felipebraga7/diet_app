import 'package:uuid/uuid.dart';

import 'eatable.dart';

class Food extends Eatable {

  @override
  late final String id;
  @override
  final double caloriesPerUnit;
  @override
  final double proteinPerUnit;
  @override
  final double carbsPerUnit;
  @override
  final double fatPerUnit;

  Food({
    required name,
    required standardQuantity,
    required this.caloriesPerUnit,
    required this.proteinPerUnit,
    required this.carbsPerUnit,
    required this.fatPerUnit,
  }) : super(name, standardQuantity) {
    id = Uuid().v4();

  }

  Food._({
    required this.id,
    required name,
    required standardQuantity,
    required this.caloriesPerUnit,
    required this.proteinPerUnit,
    required this.carbsPerUnit,
    required this.fatPerUnit,
  }) : super(name, standardQuantity);

  @override
  String getPortionCalories() {
    return (caloriesPerUnit * standardQuantity).toStringAsFixed(2);
  }

  @override
  String getPortionCarbs() {
    return (carbsPerUnit * standardQuantity).toStringAsFixed(2);
  }

  @override
  String getPortionProtein() {
    return (proteinPerUnit * standardQuantity).toStringAsFixed(2);
  }

  @override
  String getPortionFat() {
    return (fatPerUnit * standardQuantity).toStringAsFixed(2);
  }

  Food.empty()
      : id = Uuid().v4(),
        caloriesPerUnit = 0,
        proteinPerUnit = 0,
        carbsPerUnit = 0,
        fatPerUnit = 0,
        super('', 0);

  @override
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food._(
      id: json['id'],
      name: json['name'],
      standardQuantity: json['standardQuantity'],
      caloriesPerUnit: json['caloriesPerUnit'],
      proteinPerUnit: json['proteinPerUnit'],
      carbsPerUnit: json['carbsPerUnit'],
      fatPerUnit: json['fatPerUnit'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'food',
      'id': id,
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
