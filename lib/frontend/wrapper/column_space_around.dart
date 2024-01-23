import 'package:flutter/material.dart';

class ColumnSpaceAround extends StatelessWidget {
  final List<Widget> children;

  const ColumnSpaceAround({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }
}
