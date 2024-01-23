import 'package:flutter/material.dart';

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
