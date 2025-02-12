import 'package:flutter/material.dart';

class SimpleDivider extends StatelessWidget {
  final EdgeInsets padding;

  const SimpleDivider({
    this.padding = EdgeInsets.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}
