import 'package:diet_app/model/food.dart';
import 'package:uuid/uuid.dart';

import 'eatable.dart';

class FoodGroup extends Eatable {
  late final String id;
  final String name;
  List<FoodQuantity> foodQuantityList;

  FoodGroup({
    required this.name,
    required this.foodQuantityList,
  }) {
    id = Uuid().v4();
  }

  FoodGroup._({
    required this.id,
    required this.name,
    required this.foodQuantityList,
  });

  FoodGroup.empty()
      : id = Uuid().v4(),
        name = '',
        foodQuantityList = [];

  FoodGroup copyWith({
    String? id,
    String? name,
    List<FoodQuantity>? foodQuantityList,
  }) {
    return FoodGroup._(
      id: id ?? this.id,
      name: name ?? this.name,
      foodQuantityList: foodQuantityList ?? this.foodQuantityList,
    );
  }

  @override
  String getPortionCalories() {
    return foodQuantityList.map((fq) => fq.food.caloriesPerUnit*fq.quantity).reduce((val, element) => val + element).toStringAsFixed(2);
  }

  @override
  String getPortionCarbs() {
    return foodQuantityList.map((fq) => fq.food.carbsPerUnit*fq.quantity).reduce((val, element) => val + element).toStringAsFixed(2);
  }

  @override
  String getPortionProtein() {
    return foodQuantityList.map((fq) => fq.food.proteinPerUnit*fq.quantity).reduce((val, element) => val + element).toStringAsFixed(2);
  }

  @override
  String getPortionFat() {
    return foodQuantityList.map((fq) => fq.food.fatPerUnit*fq.quantity).reduce((val, element) => val + element).toStringAsFixed(2);
  }

  @override
  factory FoodGroup.fromJson(Map<String, dynamic> json) {
    return FoodGroup._(
      id: json['id'],
      name: json['name'],
      foodQuantityList: (json['foodQuantityList'] as List<dynamic>).map<FoodQuantity>((e) => FoodQuantity.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'foodGroup',
      'id': id,
      'name': name,
      'foodQuantityList': foodQuantityList!.map((fq) => fq.toJson()).toList(),
    };
  }

  @override
  double get caloriesPerUnit {
    return foodQuantityList.map((fq) => fq.food.caloriesPerUnit*fq.quantity).reduce((val, element) => val + element);
  }

  @override
  double get proteinPerUnit {
    return foodQuantityList.map((fq) => fq.food.proteinPerUnit*fq.quantity).reduce((val, element) => val + element);
  }

  @override
  double get carbsPerUnit {
    return foodQuantityList.map((fq) => fq.food.carbsPerUnit*fq.quantity).reduce((val, element) => val + element);
  }

  @override
  double get fatPerUnit {
    return foodQuantityList.map((fq) => fq.food.fatPerUnit*fq.quantity).reduce((val, element) => val + element);
  }

}

class FoodQuantity {
  final Food food;
  final double quantity;

  FoodQuantity(this.food, this.quantity);

  factory FoodQuantity.fromJson(Map<String, dynamic> json) {
    return FoodQuantity(
      Food.fromJson(json['food']),
      json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'quantity': quantity,
    };
  }
}