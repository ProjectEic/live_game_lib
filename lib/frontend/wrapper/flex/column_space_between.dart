import 'package:flutter/material.dart';

/// A Column that has the main axis alignment set to spaceBetween
class ColumnSpaceBetween extends StatelessWidget {
  final List<Widget> children;

  const ColumnSpaceBetween({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
