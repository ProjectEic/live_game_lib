import 'package:flutter/material.dart';

class RowSpaceAround extends StatelessWidget {
  final List<Widget> children;

  const RowSpaceAround({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }
}
