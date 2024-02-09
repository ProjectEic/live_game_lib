import 'package:flutter/material.dart';

/// A Row that has the main axis alignment set to spaceBetween
class RowSpaceBetween extends StatelessWidget {
  final List<Widget> children;

  const RowSpaceBetween({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
