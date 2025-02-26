import 'package:diet_app/model/food.dart';
import 'package:uuid/uuid.dart';

class FoodEvent {
  late final String id;
  final Food food;
  final double quantity;

  FoodEvent({
    required this.food,
    required this.quantity,
  }) {
    id = Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'quantity': quantity,
    };
  }

  factory FoodEvent.fromJson(Map<String, dynamic> json) {
    return FoodEvent(
      food: Food.fromJson(json['food']),
      quantity: json['quantity'],
    );
  }
}