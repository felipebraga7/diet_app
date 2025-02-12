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
}