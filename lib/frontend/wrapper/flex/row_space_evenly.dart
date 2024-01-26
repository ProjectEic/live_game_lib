import 'package:flutter/material.dart';

class RowSpaceEvenly extends StatelessWidget {
  final List<Widget> children;

  const RowSpaceEvenly({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
