import 'package:uuid/uuid.dart';

import 'eatable.dart';

class EatEvent {
  late final String id;
  final Eatable eatable;
  double quantity;

  EatEvent({
    required this.eatable,
    required this.quantity,
  }) {
    id = Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'eatable': eatable.toJson(),
      'quantity': quantity,
    };
  }

  factory EatEvent.fromJson(Map<String, dynamic> json) {
    return EatEvent(
      eatable: Eatable.fromJson(json['eatable']),
      quantity: json['quantity'],
    );
  }
}