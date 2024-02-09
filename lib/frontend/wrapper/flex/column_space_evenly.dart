import 'package:flutter/material.dart';

/// A Column that has the main axis alignment set to spaceEvenly
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
