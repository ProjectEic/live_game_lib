import 'package:flutter/material.dart';

class ColumnEnd extends StatelessWidget {
  final List<Widget> children;

  const ColumnEnd({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
