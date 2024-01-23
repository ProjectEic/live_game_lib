import 'package:flutter/material.dart';

class ColumnCenter extends StatelessWidget {
  final List<Widget> children;

  const ColumnCenter({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
