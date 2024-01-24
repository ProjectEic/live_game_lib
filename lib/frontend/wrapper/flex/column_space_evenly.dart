import 'package:flutter/material.dart';

class ColumnSpaceEvenly extends StatelessWidget {
  final List<Widget> children;

  const ColumnSpaceEvenly({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
